class Stand {
  final int id;
  final String name;
  final int stock;

  Stand({required this.id, required this.name, required this.stock});

  factory Stand.fromJson(Map<String, dynamic> json) {
    return Stand(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
    };
  }
}
