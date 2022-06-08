import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'backdrop_item_event.dart';

part 'backdrop_item_state.dart';

GetIt getIt = GetIt.instance;

class BackdropItemBloc extends Bloc<BackdropItemEvent, BackdropItemState> {
  BackdropItemBloc() : super(BackdropItemInitial()) {
    // var item;
    on<ShowBackdropEvent>((event, emit) async {
      // switch (event.itemType) {
      //   case ItemType.exparience:
      //     item = await getIt<FanPageRepository>().findExparience(event.objectId);
      //     emit(ShowBackdropItem(item: item, type: event.itemType, dynamicLink: event.dynamicLink ?? ''));
      //     break;
      //   case ItemType.fanArtZone:
      //   case ItemType.vipArtZone:
      //     item = await getIt<FanPageRepository>().getFanArtZone(
      //         path: event.objectId,
      //         lang: "${Locale.fromSubtags(languageCode: Platform.localeName.substring(0, 2))}",
      //         vip: event.itemType == ItemType.vipArtZone);
      //     emit(ShowBackdropItem(item: item, type: event.itemType, dynamicLink: event.dynamicLink ?? ''));
      //     break;
      // }
    });
  }
}
