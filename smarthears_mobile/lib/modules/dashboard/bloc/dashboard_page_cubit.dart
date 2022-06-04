import 'package:bloc/bloc.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:smarthears_mobile/repositories/content_page_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:meta/meta.dart';


part 'dashboard_page_state.dart';

GetIt getIt = GetIt.instance;

class DashboardPageCubit extends Cubit<DashboardPageState> {
  final ContentPageRepository _contentPageRepository =
      getIt<ContentPageRepository>();
  DashboardPageCubit() : super(const DashboardPageInitial()) {
    getDashboardContentPage();
  }

  Future<dynamic> getToken() async => await getIt<AuthRepository>().getToken();

  Future<void> getDashboardContentPage() async {
    try {
      emit(const DashboardPageLoading());
      final contentPage =
          await _contentPageRepository.getPage(forceReload: true);
      contentPage?.soundPacks.insert(0,
          SoundPacks(name: "LIVE", secured: false, securedByPosition: false));
      emit(DashboardPageLoaded(contentPage!));
    } on Exception {
      emit(const DashboardPageError("dashboard-section.error"));
    }
  }
}
