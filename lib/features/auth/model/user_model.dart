class UserModel {
  String name;
  String email;
  String phone;
  String uid;
  String password;
  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.uid,
      required this.phone});
  Map<String, dynamic> toMap() {
    return {
      "id": uid,
      "name": name,
      "password": password,
      "email": email,
      "phone": phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map["name"] ?? "",
        password: map["password"],
        uid: map["id"] ?? "",
        phone: map["phone"] ?? "",
        email: map['email'] ?? "");
  }
  UserModel copyWith(
      {String? name,
      String? email,
      String? password,
      String? uid,
      String? phone}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
    );
  }

  String toString() {
    return "UserModel(name:$name,password:password,uid:$uid,email:$email,phone:$phone)";
  }
}
