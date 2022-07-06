part of 'dashboard_page_cubit.dart';

abstract class DashboardPageState {
  const DashboardPageState();
}

class DashboardPageInitialState extends DashboardPageState {
  const DashboardPageInitialState();
}

class DashboardPageLoadingState extends DashboardPageState {
  const DashboardPageLoadingState();
}

class DashboardPageLoadedState extends DashboardPageState {
  const DashboardPageLoadedState();
}

class DashboardPageErrorState extends DashboardPageState {
  final String message;
  const DashboardPageErrorState(this.message);
}
