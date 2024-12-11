class User {
  final String name;
  final String email;
  final String role;
  final String department;
  final String jobNum;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.jobNum,
  });

  // Convert User object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'jobNum': jobNum,
    };
  }

  // Convert JSON Map to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      department: json['department'] as String,
      jobNum: json['jobNum'] as String,
    );
  }

  // Convert User object to a Map (for storage)
  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'jobNum': jobNum,
    };
  }

  // Convert Map back to User object
  static User fromMap(Map<String, String> map) {
    return User(
      name: map['name']!,
      email: map['email']!,
      role: map['role']!,
      department: map['department']!,
      jobNum: map['jobNum']!,
    );
  }
}