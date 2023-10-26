class Skill {
  final String name;

  Skill({required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] ?? "",
    );
  }
}
