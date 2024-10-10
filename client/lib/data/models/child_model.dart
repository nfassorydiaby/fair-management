class Child {
  final int id;
  final String name;
  final int tokens;

  Child({required this.id, required this.name, required this.tokens});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      tokens: json['tokens'],
    );
  }
}
