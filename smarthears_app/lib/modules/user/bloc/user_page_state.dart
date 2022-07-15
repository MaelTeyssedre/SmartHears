part of 'user_page_bloc.dart';

abstract class UserPageState {
  const UserPageState();
}

class UserPageInitialState extends UserPageState {}

class UserPageLoadingState extends UserPageState {}

class UserPageLoadedState extends UserPageState {
  final User user;
  UserPageLoadedState({required this.user});
}
