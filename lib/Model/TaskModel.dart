
class TaskModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String dateSubmitted; // Use Timestamp from cloud_firestore
  String status;
  final String senderId;
  final String category;// ComplainBox
  double? rating =0;
  final String? name;
  final String phone;
  final List<String> users;
  TaskModel( {
    required this.phone,
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.dateSubmitted,
    this.status = 'Pending',
    required this.senderId,
    required this.category,
    this.rating,
     required this.name,
    required this.users
  });

  factory TaskModel.fromMap(Map<String, dynamic> data) {
    return TaskModel(
      phone: data['phone'],
        id: data['id'],
        title: data['title'],
        description: data['description'],
        location: data['location'],
        dateSubmitted: data['dateSubmitted'],
        status: data['status'] ?? 'Pending',
        senderId: data['senderId'],
        category: data['category'],
        rating:  data['rating'] ?? 0.0,
        name:  data["name"] ?? "",
        users: List<String>.from(data['users'])?? [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'phone':phone,
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'dateSubmitted': dateSubmitted,
      'status': status,
      'senderId': senderId,
      'category': category,
      'rating':rating,
      'name' : name,
      "users" :users
    };
  }
}
