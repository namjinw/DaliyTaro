class User {
  String name;
  int age;
  String gender;
  DateTime birth;
  String birthTime;
  int moon;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.birth,
    required this.birthTime,
    required this.moon,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'gender': gender,
    'birth': birth.toIso8601String(),
    'birthTime': birthTime,
    'moon': moon,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      birth: json['birth'] != null
          ? DateTime.parse(json['birth'])
          : DateTime.now(),
      birthTime: json['birthTime'] ?? '',
      moon: json['moon'] ?? 0,
    );
  }

  factory User.empty() {
    return User(
      name: '',
      age: 1,
      gender: '',
      birth: DateTime(DateTime.now().year, DateTime.now().month, 1, 9),
      birthTime: '21:00',
      moon: 10,
    );
  }
}
