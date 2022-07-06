part of 'home_page_cubit.dart';

abstract class HomePageState {
  const HomePageState();
}

class HomePageInitialState extends HomePageState {
  const HomePageInitialState();
}

class HomePageLoadingState extends HomePageState {
  const HomePageLoadingState();
}

class HomePageLoadedState extends HomePageState {
  const HomePageLoadedState();
}

class HomePageErrorState extends HomePageState {
  final String message;
  const HomePageErrorState(this.message);
}
