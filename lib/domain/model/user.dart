import 'package:hackatrix/domain/model/role.dart';

class User {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final Role role;
  final bool isModerator;
  final bool isStaff;
  final bool isJury;
  final bool isPasswordResetRequired;

  User({this.id, this.fullName, this.email, this.phoneNumber, this.role, this.isModerator, this.isStaff, this.isJury, this.isPasswordResetRequired});

  factory User.fromJson(Map<String, dynamic> json){
      return new User(
        id: json['id'],
        fullName :json['full_name'],
        email :json['email'],
        phoneNumber:json['phone_number'],
        role: Role.fromJson(json['role']),
        isModerator: json['is_moderator'],
        isStaff: json['is_staff'],
        isJury: json['is_jury'],
        isPasswordResetRequired: json['is_password_reset_required'],
        );
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'is_moderator': isModerator,
      'is_staff': isStaff,
      'is_jury': isJury,
      'is_password_reset_required': isPasswordResetRequired,

    };
}