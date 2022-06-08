import 'package:bloc/bloc.dart';
part 'package:smarthears_app/modules/home/bloc/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageInitialState()) {
    try {
      emit(const HomePageLoadedState());
    } on Exception {
      emit(const HomePageErrorState("Couldn't fetch the page. Is the device online?"));
    }
  }
}
