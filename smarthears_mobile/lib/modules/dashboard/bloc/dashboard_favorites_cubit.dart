import 'package:bloc/bloc.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'dashboard_favorites_state.dart';

GetIt getIt = GetIt.instance;

class DashboardFavoritesCubit extends Cubit<DashboardFavoritesState> {
  late List<SoundPacks> favorites;

  DashboardFavoritesCubit() : super(const DashboardPageInitial(<SoundPacks>[])) {
    favorites = [];
  }

  void initFavorites(List<SoundPacks> initFavorites) {
    favorites = initFavorites;
    emit(DashboardPageInitial(favorites));
  }

  void addFavorite(SoundPacks exparience) {
    favorites.add(exparience);
    emit(DashboardFavoritesAdd(favorites));
  }

  void removeFavorite(SoundPacks exparience) {
    favorites.removeWhere((exp) => exp.id == exparience.id);
    emit(DashboardFavoritesRemove(favorites));
  }
}
