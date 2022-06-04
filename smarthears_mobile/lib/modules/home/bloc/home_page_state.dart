part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  const HomePageInitial();
}

class HomePageLoading extends HomePageState {
  const HomePageLoading();
}

class HomePageLoaded extends HomePageState {
  const HomePageLoaded(this.badge);
  final int badge;

  @override
  bool operator ==(Object other) => (identical(this, other)) ? true : other is HomePageLoaded && other.badge == badge;

  @override
  int get hashCode => badge.hashCode;
}

class HomePageError extends HomePageState {
  final String message;
  const HomePageError(this.message);

  @override
  bool operator ==(Object other) =>
      (identical(this, other)) ? true : other is HomePageError && other.message == message;

  @override
  int get hashCode => message.hashCode;
}
