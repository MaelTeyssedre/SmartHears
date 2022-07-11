part of 'backdrop_item_bloc.dart';

@immutable
abstract class BackdropItemState {}

class BackdropItemInitialState extends BackdropItemState {}

class ShowBackdropItem extends BackdropItemState {
  ShowBackdropItem({required this.item, required this.type});
  final Item item;
  final ItemType type;
}

class PayBackdropItem extends BackdropItemState {
  PayBackdropItem({required this.item, required this.type});
  final Item item;
  final ItemType type;
}
