import 'package:equatable/equatable.dart';

/// User model
///
/// [User.empty] represents an unauthenticated user.
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.phone,
  });

  /// covert [Map] to [User]
  factory User.fromJson(Map<String, dynamic> userMap) {
    return User(
      id: userMap['id'].toString(),
      email: userMap['email'].toString(),
      phone: userMap['phone'].toString(),
      name: userMap['name'].toString(),
    );
  }

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Url for the current user's photo.
  final String? phone;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// convert [User] to [Map]
  Map<String, String> toJson(User user) {
    return {
      'name': user.name!,
      'email': user.email!,
      'phone': user.phone!,
    };
  }

  @override
  List<Object?> get props => [email, id, name, photo, phone];
}
