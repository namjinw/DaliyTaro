class User {
  String name;
  int age;
  String gender;
  DateTime birth;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.birth,
  });

  factory User.empty() {
    return User(name: '', age: 0, gender: 'M', birth: DateTime(DateTime.now().year, DateTime.now().month, 9, 0));
  }
}
