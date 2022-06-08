import 'package:bloc/bloc.dart';
import 'package:smarthears_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
part 'backdrop_item_event.dart';
part 'backdrop_item_state.dart';

GetIt getIt = GetIt.instance;

class BackdropItemBloc extends Bloc<BackdropItemEvent, BackdropItemState> {
  BackdropItemBloc() : super(BackdropItemInitial()) {
    on<ShowBackdropEvent>((event, emit) async => emit(ShowBackdropItemState(
        item: null,
        type: event.itemType,
        dynamicLink: event.dynamicLink ?? '')));
  }
}
