part of 'dashboard_page_cubit.dart';

@immutable
abstract class DashboardPageState {
  const DashboardPageState();
}

class DashboardPageInitial extends DashboardPageState {
  const DashboardPageInitial();
}

class DashboardPageLoading extends DashboardPageState {
  const DashboardPageLoading();
}

class DashboardPageLoaded extends DashboardPageState {
  const DashboardPageLoaded(this.contentPage);
  final ContentPage contentPage;

  @override
  bool operator ==(Object other) =>
      (identical(this, other)) ? true : other is DashboardPageLoaded && other.contentPage == contentPage;

  @override
  int get hashCode => contentPage.hashCode;
}

class DashboardPageError extends DashboardPageState {
  final String message;
  const DashboardPageError(this.message);

  @override
  bool operator ==(Object other) =>
      (identical(this, other)) ? true : other is DashboardPageError && other.message == message;

  @override
  int get hashCode => message.hashCode;
}
