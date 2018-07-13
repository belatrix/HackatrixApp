class City {
  final int id;
  final String name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
      return new City(
        id: json['id'],
        name: json['name'],
      );
    }
}
