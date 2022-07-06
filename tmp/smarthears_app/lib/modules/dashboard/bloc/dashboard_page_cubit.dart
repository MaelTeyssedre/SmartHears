import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_page_state.dart';

class DashboardPageCubit extends Cubit<DashboardPageState> {
  DashboardPageCubit() : super(const DashboardPageInitialState()) {
    try {
      emit(const DashboardPageLoadingState());
      emit(const DashboardPageLoadedState());
    } on Exception {
      emit(const DashboardPageErrorState("dashboard-section.error"));
    }
  }

}
