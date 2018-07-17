class Event {
  final int id;
  String title;
  final String image;
  final String details;
  final String datetime;
  final String address;
  final String registerLink;
  final bool isUpcoming;
  final bool isGoing;

  Event(
      {this.id,
      this.title,
      this.image,
      this.details,
      this.datetime,
      this.address,
      this.registerLink,
      this.isUpcoming,
      this.isGoing});

  factory Event.fromJson(Map<String, dynamic> json) {
    return new Event(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      details: json['details'],
      datetime: json['datetime'],
      address: json['address'],
      registerLink: json['register_link'],
      isUpcoming: json['is_upcoming'],
      isGoing: false,
    );
  }
}
