import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.login, this.email, this.role, this.passwordReset);

  final int id;
  final String login;
  final String email;
  final String role;
  final bool passwordReset;

  @override
  List<Object> get props => [id, login, email, role, passwordReset];

  factory User.fromJson(dynamic json) => User(json['id'] as int, json['login'] as String, json['email'] as String,
      json['role'] as String, json['passwordReset'] == 1 ? false : true);

  @override
  String toString() => '{ ${this.id}, ${this.login}, ${this.email}, ${this.role}, ${this.passwordReset} }';
}
