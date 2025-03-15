class EntityTask {
  String id;
  String name;
  String description;

  EntityTask({required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory EntityTask.fromMap(Map<String, dynamic> map) {
    return EntityTask(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
