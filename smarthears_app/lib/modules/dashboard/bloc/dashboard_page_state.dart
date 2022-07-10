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
  final List<Sound> sounds;
  final List<SoundPack> soundPacks;
  final List<Voice> voices;
  final List<VoicePack> voicePacks;
  const DashboardPageLoadedState({required this.soundPacks, required this.sounds, required this.voicePacks, required this.voices});
}

class DashboardPageErrorState extends DashboardPageState {
  final String message;
  const DashboardPageErrorState(this.message);
}
