class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final String role; // "admin", "volunteer", "user"

  final String address; // Current location of the user
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.role,
    required this.address,
    required this.createdAt,
  });

  // Convert UserModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "profileImageUrl": profileImageUrl,
      "role": role,
      "location": address,
      "createdAt": createdAt.toIso8601String(),
    };
  }
  // Create UserModel from Firestore JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      profileImageUrl: json["profileImageUrl"],
      role: json["role"],
      address: json["location"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
