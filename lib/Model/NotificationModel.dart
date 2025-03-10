
class NotificationModel {
  final String id;
  final String title;
  final String description;
  final List<String> imagePaths;
  final String location;
  final String dateSubmitted; // Use Timestamp from cloud_firestore
  String status;
  final String senderId;
  final String category;// ComplainBox
  double? rating =0;
  String? name;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.location,
    required this.dateSubmitted,
    this.status = 'Pending',
    required this.senderId,
    required this.category,
    this.rating,
    this.name
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      imagePaths: List<String>.from(data['imagePaths'])?? [],
      location: data['location'],
      dateSubmitted: data['dateSubmitted'],
      status: data['status'] ?? 'Pending',
      senderId: data['senderId'],
      category: data['category'],
      rating:  data['rating'] ?? 0.0,
      name:  data["name"] ?? ""
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePaths': imagePaths,
      'location': location,
      'dateSubmitted': dateSubmitted,
      'status': status,
      'senderId': senderId,
      'category': category,
      'rating':rating,
      'name' : name
    };
  }
}
