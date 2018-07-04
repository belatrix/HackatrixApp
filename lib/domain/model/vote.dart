class Vote {
  final int id;
  final String title;
  final int votes;

  Vote({this.id, this.title, this.votes});

  factory Vote.fromJson(Map<String, dynamic> json) {
      return new Vote(
        id: json['id'],
        title: json['title'],
        votes: json['votes'],
      );
    }
}
