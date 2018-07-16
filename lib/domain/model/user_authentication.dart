class UserAuthentication {
  final bool isBlocked;
  final bool isPasswordResetRequired;
  final String token;
  final String email;
  final bool isStaff;
  final bool isJury;
  final bool isModerator;
  final bool isActive;
  final int userId;

  UserAuthentication(
      {this.isBlocked,
      this.isPasswordResetRequired,
      this.token,
      this.email,
      this.isStaff,
      this.isJury,
      this.isModerator,
      this.isActive,
      this.userId});

  factory UserAuthentication.fromJson(Map<String, dynamic> json) {
    return new UserAuthentication(
      isBlocked: json['is_blocked'],
      isPasswordResetRequired: json['is_password_reset_required'],
      token: json['token'],
      email: json['email'],
      isStaff: json['is_staff'],
      isJury: json['is_jury'],
      isModerator: json['is_moderator'],
      isActive: json['is_active'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_blocked': isBlocked,
        'is_password_reset_required': isPasswordResetRequired,
        'token': token,
        'email': email,
        'is_staff': isStaff,
        'is_jury': isJury,
        'is_moderator': isModerator,
        'is_active': isActive,
        'user_id': userId,
      };
}
