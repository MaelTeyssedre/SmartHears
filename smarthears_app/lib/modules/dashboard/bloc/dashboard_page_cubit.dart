import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/models/sound.dart';
import 'package:smarthears_app/models/sound_pack.dart';
import 'package:smarthears_app/models/theme.dart';
import 'package:smarthears_app/models/voice.dart';
import 'package:smarthears_app/models/voice_pack.dart';

part 'dashboard_page_state.dart';

/*   local data for debug, just switch with emit(const DashboardPageLoadedState(soundPacks: [], sounds: [], voicePacks: [], voices: []));

      emit(DashboardPageLoadedState(soundPacks: [
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
      ], sounds: [
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton)
      ], voicePacks: [
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton)
      ], voices: [
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton)
      ]));
*/

class DashboardPageCubit extends Cubit<DashboardPageState> {
  DashboardPageCubit() : super(const DashboardPageInitialState()) {
    try {
      emit(const DashboardPageLoadingState());
      emit(DashboardPageLoadedState(soundPacks: [
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton)
      ], sounds: [
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton)
      ], voicePacks: [
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton)
      ], voices: [
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton)
      ]));
    } on Exception {
      emit(const DashboardPageErrorState("Error"));
    }
  }

  Future<void> getDashboard() async {
    try {
      emit(const DashboardPageLoadingState());
      emit(DashboardPageLoadedState(soundPacks: [
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
        SoundPack(title: 'test', logoUrl: urlDrapeauBreton),
      ], sounds: [
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton),
        Sound(title: 'test', logoUrl: urlDrapeauBreton)
      ], voicePacks: [
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton),
        VoicePack(title: 'test', logoUrl: urlDrapeauBreton)
      ], voices: [
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton),
        Voice(title: 'test', logoUrl: urlDrapeauBreton)
      ]));
    } on Exception {
      emit(const DashboardPageErrorState("Error"));
    }
  }
}
