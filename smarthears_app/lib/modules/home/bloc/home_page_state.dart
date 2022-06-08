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

  @override
  bool operator ==(Object other) =>
      (identical(this, other)) ? true : other is HomePageErrorState && other.message == message;

  @override
  int get hashCode => message.hashCode;
}
