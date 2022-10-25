class UserModel3 {
  final String? id;
  final String? name;
  final String? avatar;

  UserModel3(
      { this.id,  this.name, this.avatar});

  factory UserModel3.fromJson(Map<String, dynamic> json) {
    return UserModel3(
      id: json["id"],
      name: json["name"],
      avatar: json["image"],
    );
  }

  static List<UserModel3> fromJsonList(List list) {
    return list.map((item) => UserModel3.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel3 model) {
    return this.id == model.id;
  }

  @override

  String toString() => name!;
}