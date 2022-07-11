part of 'backdrop_item_bloc.dart';

@immutable
class BackdropItemEvent {}

class ShowBackdropEvent extends BackdropItemEvent {
  ShowBackdropEvent({required this.itemType, required this.item});
  final Item item;
  final ItemType itemType;
}
