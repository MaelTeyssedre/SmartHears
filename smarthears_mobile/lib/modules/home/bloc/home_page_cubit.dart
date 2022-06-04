import 'package:bloc/bloc.dart';
import 'package:smarthears_mobile/device_info.dart';
// import 'package:digitmuz_app/repositories/authentication_repository.dart';
import 'package:smarthears_mobile/repositories/notification_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

GetIt getIt = GetIt.instance;

class HomePageCubit extends Cubit<HomePageState> {
  final NotificationRepository _notificationRepository = getIt<NotificationRepository>();
  // final AuthenticationRepository _authenticationRepository = getIt<AuthenticationRepository>();
  final DeviceInfo _deviceInfo = getIt<DeviceInfo>();

  HomePageCubit() : super(HomePageInitial()) {
    getBadge();
  }

  Future<void> getBadge() async {
    try {
      emit(HomePageLoading());
      final badge = await _notificationRepository.getBadge(
          _deviceInfo.getDeviceData().id);
      emit(HomePageLoaded(badge));
    } on Exception {
      emit(HomePageError("Couldn't fetch the page. Is the device online?"));
    }
  }
}
