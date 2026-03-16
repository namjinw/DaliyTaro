class Soul {
  final int number;
  final String name;
  final String storytelling;
  final String image;

  Soul({
    required this.number,
    required this.name,
    required this.storytelling,
    required this.image,
  });

  factory Soul.fromJson(Map<String, dynamic> json) => Soul(
    number: json['number'],
    name: json['name'],
    storytelling: json['storytelling'],
    image: json['image'],
  );
}
