part of 'backdrop_item_bloc.dart';

@immutable
abstract class BackdropItemEvent {}

class ShowBackdropEvent extends BackdropItemEvent {
  ShowBackdropEvent({required this.itemType, required this.objectId, this.dynamicLink});
  final String objectId;
  final ItemType itemType;
  final String? dynamicLink;
}
