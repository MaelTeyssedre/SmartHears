part of 'backdrop_item_bloc.dart';

@immutable
abstract class BackdropItemState {}

class BackdropItemInitial extends BackdropItemState {}

class GoToSphere extends BackdropItemState {
  GoToSphere(this.sphereId);
  final String sphereId;
}

class ShowBackdropItemState extends BackdropItemState {
  ShowBackdropItemState({required this.item, required this.type, required this.dynamicLink});
  final dynamic item;
  final ItemType type;
  final String dynamicLink;
}

class PayBackdropItemState extends BackdropItemState {
  PayBackdropItemState({this.item, required this.type, required this.dynamicLink});
  final dynamic item;
  final ItemType type;
  final String dynamicLink;
}
