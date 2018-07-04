class Role {
  final int id;
  final String name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return new Role(
        id: json['id'],
        name: json['name'],
      );
    }
    return Role();
  }

   Map<String, dynamic> toJson() =>
    {
      'id': id,
      'name': name,
    };
}
