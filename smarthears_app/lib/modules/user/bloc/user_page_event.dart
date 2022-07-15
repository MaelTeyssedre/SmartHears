part of 'user_page_bloc.dart';

abstract class UserPageEvent {
  const UserPageEvent();
}

class FetchUserEvent extends UserPageEvent {
  final String id;

  FetchUserEvent({required this.id});
}

class UpdateUserEvent extends UserPageEvent {
  final User user;

  UpdateUserEvent({required this.user});
}
