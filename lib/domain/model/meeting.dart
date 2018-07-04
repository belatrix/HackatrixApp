class Meeting {
  final int id;
  final String name;

  Meeting({this.id, this.name});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return new Meeting(
      id: json['id'],
      name: json['name'],
    );
  }
}
