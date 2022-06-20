import '../../core/utils/string.dart';

class Client {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? address;
  final String? profilePictureUrl;
  final String? caption;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.profilePictureUrl,
    required this.caption,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int,
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      email: json['email'] as String,
      address: (json['address'] as String?).isEmptyOrNull
          ? null
          : json['address'] as String,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'address': address ?? '',
      'photo': profilePictureUrl ?? '',
      'caption': caption ?? '',
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Client copyWith({
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return Client(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address,
      profilePictureUrl: profilePictureUrl,
      caption: caption,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
