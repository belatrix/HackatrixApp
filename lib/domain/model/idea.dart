import 'package:hackatrix/domain/model/user.dart';

class Idea {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isValid;
  final User author;

  Idea(
      {this.id,
      this.title,
      this.description,
      this.isCompleted,
      this.isValid,
      this.author});

  factory Idea.fromJson(Map<String, dynamic> json) {
    return new Idea(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'],
      isValid: json['is_valid'],
      author: User.fromJson(json['author']),
    );
  }
}
