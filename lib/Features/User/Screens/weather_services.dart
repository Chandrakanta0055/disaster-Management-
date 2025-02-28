import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<Position?> _currentPosition = ValueNotifier(null);
  final ValueNotifier<List<Map<String, dynamic>>> _disasterLocations = ValueNotifier([]);
  final ValueNotifier<bool> _locationPermissionGranted = ValueNotifier(false);
  final ValueNotifier<double?> _temperature = ValueNotifier(null);
  final ValueNotifier<String> _safetyStatus = ValueNotifier("Loading...");
  final ValueNotifier<List<Map<String, dynamic>>> _realtimeDisasters = ValueNotifier([]);
  bool _isSatelliteView = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _fetchDisasterData();
    _fetchRealtimeDisasters();
  }

  Future<void> _checkPermissions() async {
    if (await Permission.location.request().isGranted) {
      _locationPermissionGranted.value = true;
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentPosition.value = position;
      _fetchWeatherData(position.latitude, position.longitude);
      print(position);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _fetchDisasterData() async {
    String apiKey = "AIzaSyCZnmr2xwixY_izx8EACPLeCEPAJ1x6Fz8"; // Replace with a valid API key
    String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=disaster&location=20.2961,85.8245&radius=50000&type=point_of_interest&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _disasterLocations.value = List<Map<String, dynamic>>.from(data['results'].map((place) => {
          "latLng": LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']),
          "name": place['name'],
          "vicinity": place['vicinity'],
          "type": "Flood",
          "description": "Recent flood reported in this area."
        }));
      }
    } catch (e) {
      print("Error fetching disaster data: $e");
    }
  }

  Future<void> _fetchWeatherData(double lat, double lon) async {
    String url = "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&hourly=temperature_2m";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double temp = data['hourly']['temperature_2m'][0]; // Get the latest temperature
        _temperature.value = temp;
        _safetyStatus.value = _evaluateSafety(temp);
      }
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  String _evaluateSafety(double temperature) {
    if (temperature < 5) {
      return "❄ Extreme Cold! Stay warm!";
    } else if (temperature > 40) {
      return "🔥 Extreme Heat! Stay hydrated!";
    } else {
      return "✅ You are safe.";
    }
  }

  Future<void> _fetchRealtimeDisasters() async {
    String url = "https://eonet.gsfc.nasa.gov/api/v3/events";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Map<String, dynamic>> events = List<Map<String, dynamic>>.from(data['events']);

        List<Map<String, dynamic>> odishaEvents = events.where((event) {
          if (event['geometry'] != null && event['geometry'].isNotEmpty) {
            return event['geometry'].any((geo) {
              if (geo['coordinates'] != null && geo['coordinates'].isNotEmpty) {
                double lon = geo['coordinates'][0];
                double lat = geo['coordinates'][1];
                return lat >= 17.7 && lat <= 22.5 && lon >= 81.3 && lon <= 87.5; // Odisha bounding box
              }
              return false;
            });
          }
          return false;
        }).toList();

        _realtimeDisasters.value = odishaEvents.map((event) {
          return {
            "title": event['title'],
            "type": event['categories'][0]['title'],
            "geometry": event['geometry'],
          };
        }).toList();
      }
    } catch (e) {
      print("Error fetching realtime disasters: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Disaster Management Nearby", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.green[900]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<Position?>(
                  valueListenable: _currentPosition,
                  builder: (context, position, child) {
                    return position == null
                        ? Center(child: CircularProgressIndicator(color: Colors.white))
                        : _mapContainer("📍 My Location:", LatLng(position.latitude, position.longitude), Colors.red);
                  },
                ),
                SizedBox(height: 16),
                ValueListenableBuilder<double?>(
                  valueListenable: _temperature,
                  builder: (context, temp, child) {
                    return temp == null
                        ? Center(child: CircularProgressIndicator(color: Colors.white))
                        : Text("🌡 Temperature: ${temp.toStringAsFixed(1)}°C", style: _sectionTitleStyle());
                  },
                ),
                SizedBox(height: 8),
                ValueListenableBuilder<String>(
                  valueListenable: _safetyStatus,
                  builder: (context, safety, child) {
                    return Text("🛑 Safety Status: $safety", style: _sectionTitleStyle());
                  },
                ),
                SizedBox(height: 16),
                Text("Realtime Disaster Status (Odisha)", style: _sectionTitleStyle()),
                SizedBox(height: 8),
                ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: _realtimeDisasters,
                  builder: (context, disasters, child) {
                    if (disasters.isEmpty) {
                      return Column(
                        children: [
                          Container(
                            height: screenHeight * 0.5, // Responsive height
                            width: screenWidth, // Responsive width
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(20.5937, 85.8232), // Center on Odisha
                                initialZoom: 7,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: _isSatelliteView
                                      ? "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}"
                                      : "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Map View"),
                              Switch(
                                value: _isSatelliteView,
                                onChanged: (value) {
                                  setState(() {
                                    _isSatelliteView = value;
                                  });
                                },
                              ),
                              Text("Satellite View"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text("No realtime disaster status found in this area.", style: TextStyle(color: Colors.black)),
                        ],
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: disasters.length,
                      itemBuilder: (context, index) {
                        final disaster = disasters[index];
                        LatLng position = LatLng(
                          disaster['geometry'][0]['coordinates'][1],
                          disaster['geometry'][0]['coordinates'][0],
                        );
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(10),
                          decoration: _boxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("⚠ ${disaster['type']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                              Text("${disaster['title']}", style: TextStyle(fontSize: 14, color: Colors.white)),
                              _mapContainer("", position, Colors.orange),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 16),
                Text("Disaster Management Locations", style: _sectionTitleStyle()),
                SizedBox(height: 8),
                ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: _disasterLocations,
                  builder: (context, disasterList, child) {
                    return disasterList.isEmpty
                        ? Center(child: CircularProgressIndicator(color: Colors.white))
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: disasterList.length,
                      itemBuilder: (context, index) => _mapCard(disasterList[index]),
                    );
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mapCard(Map<String, dynamic> disaster) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("⚠ ${disaster['type']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
          Text("${disaster['name']} - ${disaster['vicinity']}", style: TextStyle(fontSize: 14, color: Colors.white)),
          _mapContainer("", disaster["latLng"], Colors.orange),
        ],
      ),
    );
  }

  Widget _mapContainer(String title, LatLng position, Color markerColor) {
    return Column(
      children: [
        if (title.isNotEmpty) Text(title, style: _sectionTitleStyle()),
        SizedBox(height: 10),
        Container(
          height: 150,
          child: FlutterMap(
            options: MapOptions(initialCenter: position, initialZoom: 12),
            children: [
              TileLayer(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"),
              MarkerLayer(
                markers: [
                  Marker(point: position, width: 30, height: 30, child: Icon(Icons.location_on, color: markerColor, size: 30)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12));
  TextStyle _sectionTitleStyle() => TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow);
}