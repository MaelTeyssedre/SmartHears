import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_app/app.dart';
import 'package:smarthears_app/models/user.dart';
import 'package:smarthears_app/repositories/user_repository.dart';

part 'user_page_event.dart';
part 'user_page_state.dart';

GetIt getIt = GetIt.instance;

class UserPageBloc extends Bloc<UserPageEvent, UserPageState> {
  UserPageBloc() : super(UserPageInitialState()) {
    on<UpdateUserEvent>((event, emit) async {
      emit(UserPageLoadingState());
    });
    on<FetchUserEvent>((event, emit) async {
      emit(UserPageLoadingState());
      User? user = await getIt<UserRepository>().getUser();
      emit(UserPageLoadedState(user: (await getIt<UserRepository>().getUser())!));
    });
  }
}
