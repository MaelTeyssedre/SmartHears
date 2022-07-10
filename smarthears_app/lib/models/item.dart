import 'package:smarthears_app/models/sound.dart';
import 'package:smarthears_app/models/sound_pack.dart';
import 'package:smarthears_app/models/voice.dart';
import 'package:smarthears_app/models/voice_pack.dart';

enum ItemType { voice, soundPack, voicePack, sound }

const Map<ItemType, Type> itemTypeMap = {ItemType.voice: Voice, ItemType.sound: Sound, ItemType.voicePack: VoicePack, ItemType.soundPack: SoundPack};

abstract class Item {
  final String title;
  final String logoUrl;
  Item({required this.title, required this.logoUrl});
}
