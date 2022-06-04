part of 'dashboard_favorites_cubit.dart';

@immutable
abstract class DashboardFavoritesState {
  const DashboardFavoritesState(this.favorites);
  final List<SoundPacks> favorites;
}

class DashboardPageInitial extends DashboardFavoritesState {
  const DashboardPageInitial(List<SoundPacks> favorites) : super(favorites);
}

class DashboardFavoritesAdd extends DashboardFavoritesState {
  const DashboardFavoritesAdd(List<SoundPacks> favorites) : super(favorites);
}

class DashboardFavoritesRemove extends DashboardFavoritesState {
  const DashboardFavoritesRemove(List<SoundPacks> favorites) : super(favorites);
}
