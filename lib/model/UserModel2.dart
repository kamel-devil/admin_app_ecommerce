class UserModel2 {
  final String? id;
  final String? name;
  final String? avatar;

  UserModel2(
      { this.id,  this.name, this.avatar});

  factory UserModel2.fromJson(Map<String, dynamic> json) {
    return UserModel2(
      id: json["id"],
      name: json["name"],
      avatar: json["image"],
    );
  }

  static List<UserModel2> fromJsonList(List list) {
    return list.map((item) => UserModel2.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel2 model) {
    return this.id == model.id;
  }

  @override

  String toString() => name!;
}