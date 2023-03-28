class UserModel {
  final String name;
  final String email;
  final bool isOlderly;

  UserModel({
    required this.name,
    required this.email,
    required this.isOlderly,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      isOlderly: map['isOlderly'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isOlderly': isOlderly,
    };
  }
}
