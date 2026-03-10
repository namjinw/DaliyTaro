class User {
  String name;
  int age;
  String gender;
  DateTime birth;
  String birthTime;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.birth,
    required this.birthTime,
  });

  factory User.empty() {
    return User(
      name: '',
      age: 1,
      gender: '',
      birth: DateTime(DateTime.now().year, DateTime.now().month, 1, 9),
      birthTime: '21:00',
    );
  }
}
