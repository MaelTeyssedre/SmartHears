part of 'backdrop_item_bloc.dart';

@immutable
abstract class BackdropItemState {}

class BackdropItemInitial extends BackdropItemState {}

class GoToSphere extends BackdropItemState {
  GoToSphere(this.sphereId);
  final String sphereId;
}

class ShowBackdropItem extends BackdropItemState {
  ShowBackdropItem({required this.item, required this.type, required this.dynamicLink});
  final dynamic item;
  final ItemType type;
  final String dynamicLink;
}

class PayBackdropItem extends BackdropItemState {
  PayBackdropItem({this.item, required this.type, required this.dynamicLink});
  final dynamic item;
  final ItemType type;
  final String dynamicLink;
}
