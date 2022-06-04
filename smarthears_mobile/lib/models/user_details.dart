import 'user.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

class UserDetails {
  UserDetails(
      {required this.user,
      required this.firstname,
      required this.lastname,
      required this.birthDate,
      required this.city,
      required this.country,
      required this.avatar,
      required this.phone,
      required this.newsletter});

  final User user;
  final String firstname;
  final String lastname;
  final DateTime? birthDate;
  final String city;
  final String country;
  String? avatar;
  final bool newsletter;
  final String phone;

  List<Object> get props => [
        user.props,
        firstname,
        lastname,
        birthDate ?? '',
        city,
        country,
        avatar ?? '',
        newsletter,
        phone,
      ];

  factory UserDetails.fromJson(dynamic json) {
    try {
      return UserDetails(
        user: User.fromJson(json['account']),
        firstname: json['firstname'],
        lastname: json['lastname'],
        birthDate: DateTime.tryParse(json['birthDate'] ?? ''),
        city: json['city'],
        country: json['country'],
        avatar: json['avatar'],
        newsletter: json['newsletter'] == 1,
        phone: json['phone'],
      );
    } catch (error) {
      print(error);
      throw (error);
    }
  }
  void updateAvatar({required String avatarUrl}) => avatar = avatarUrl;

  @override
  String toString() => '{ ${this.user.toString()} }';
}

class Favorite extends Taggable {
  const Favorite({required this.id, required this.name});

  final int id;
  final String name;

  // @override
  List<Object> get props => [id, name];

  factory Favorite.fromJson(dynamic json) =>
      Favorite(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson(dynamic json) =>
      {'name': json.name, 'value': json.name, 'label': json.name};

  @override
  String toString() => '{ ${this.id}, ${this.name} }';
}
