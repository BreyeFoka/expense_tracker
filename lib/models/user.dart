class User {
  final String id;
  final String name;
  final String email;
  final String? studentId;
  final String? phoneNumber;
  final String? profilePicture;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.studentId,
    this.phoneNumber,
    this.profilePicture,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      studentId: json['studentId'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'studentId': studentId,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  User copyWith({
    String? name,
    String? email,
    String? studentId,
    String? phoneNumber,
    String? profilePicture,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      studentId: studentId ?? this.studentId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt,
    );
  }
}
