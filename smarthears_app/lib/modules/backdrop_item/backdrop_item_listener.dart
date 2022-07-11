import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smarthears_app/modules/backdrop_item/backdrop_item.dart';
import 'package:smarthears_app/modules/backdrop_item/bloc/backdrop_item_bloc.dart';
import 'package:flutter/material.dart';

class BackdropItemListener extends StatelessWidget {
  const BackdropItemListener({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => BlocListener(
      bloc: BlocProvider.of<BackdropItemBloc>(context),
      listener: (context, state) async {
        if (state is ShowBackdropItem) {
          showMaterialModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).colorScheme.primary,
              animationCurve: Curves.slowMiddle,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
              builder: (context) => BackdropItem(item: state.item, itemType: state.type));
        }
      },
      child: child);
}
