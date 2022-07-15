import 'package:smarthears_app/models/theme.dart';
import 'package:smarthears_app/models/user.dart';

class UserRepository {
  User? _user;

  UserRepository();

  // ignore: prefer_if_null_operators
  Future<User?> getUser() async => _user != null
      ? _user
      : User(
          email: 'test@test.test',
          firstname: 'test',
          lastname: 'test',
          phone: '+33661520416',
          country: 'Bretagne',
          city: 'Nantes',
          birthDate: DateTime.now(),
          id: 'test',
          avatarUrl: urlDrapeauBreton);
}
