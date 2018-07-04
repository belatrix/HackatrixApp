class Event {
  final int id;
  final String title;
  final String image;
  final String details;
  final String datetime;
  final String address;
  final String registerLink;

  Event({this.id, this.title, this.image, this.details, this.datetime, this.address, this.registerLink});

  factory Event.fromJson(Map<String, dynamic> json){
      return new Event(
        id: json['id'],
        title :json['title'],
        image :json['image'],
        details:json['details'],
        datetime:json['datetime'],
        address:json['address'],
        registerLink:json['register_link'],
        );
  }
}