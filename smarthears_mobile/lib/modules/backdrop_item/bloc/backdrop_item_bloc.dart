import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:smarthears_mobile/repositories/content_page_repository.dart';
part 'backdrop_item_event.dart';
part 'backdrop_item_state.dart';

GetIt getIt = GetIt.instance;

class BackdropItemBloc extends Bloc<BackdropItemEvent, BackdropItemState> {
  BackdropItemBloc() : super(BackdropItemInitial()) {
    var item;
    on<ShowBackdropEvent>((event, emit) async {
      switch (event.itemType) {
        case ItemType.soundPacks:
          item =
              await getIt<ContentPageRepository>().findSoundPack(event.objectId);
          emit(ShowBackdropItem(
              item: item,
              type: event.itemType,
              dynamicLink: event.dynamicLink ?? ''));
          break;
        case ItemType.voice:
          // TODO: Handle this case.
          break;
        case ItemType.voicePacks:
          // TODO: Handle this case.
          break;
        case ItemType.soundsProfile:
          // TODO: Handle this case.
          break;
      }
    });
  }
}
