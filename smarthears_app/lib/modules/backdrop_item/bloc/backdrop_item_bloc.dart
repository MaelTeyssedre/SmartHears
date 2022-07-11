import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:smarthears_app/models/item.dart';

part 'backdrop_item_state.dart';
part 'backdrop_item_event.dart';

class BackdropItemBloc extends Bloc<BackdropItemEvent, BackdropItemState> {
  BackdropItemBloc() : super(BackdropItemInitialState()) {
    on<ShowBackdropEvent>((event, emit) async => emit(ShowBackdropItem(item: event.item, type: event.itemType)));
  }
}
