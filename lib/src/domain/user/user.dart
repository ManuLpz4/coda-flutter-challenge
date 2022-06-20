import '../../core/utils/string.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePictureUrl;
  final String? caption;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePictureUrl,
    required this.caption,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      email: json['email'] as String,
      profilePictureUrl: (json['photo'] as String?).isEmptyOrNull
          ? null
          : json['photo'] as String,
      caption: (json['caption'] as String?).isEmptyOrNull
          ? null
          : json['caption'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
