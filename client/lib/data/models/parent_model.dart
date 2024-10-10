import 'child_model.dart';

class Parent {
  final int id;
  final String name;
  final List<Child> children;

  Parent({required this.id, required this.name, required this.children});

  factory Parent.fromJson(Map<String, dynamic> json) {
    var childrenFromJson = json['children'] as List;
    List<Child> childrenList = childrenFromJson.map((i) => Child.fromJson(i)).toList();

    return Parent(
      id: json['id'],
      name: json['name'],
      children: childrenList,
    );
  }
}
