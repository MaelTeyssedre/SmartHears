import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/modules/backdrop_item/backdrop_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smarthears_app/modules/backdrop_item/bloc/backdrop_item_bloc.dart';

class BackdropItemListener extends StatelessWidget {
  const BackdropItemListener({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: BlocProvider.of<BackdropItemBloc>(context),
        listener: (context, state) async {
          if (state is ShowBackdropItemState) {
            showMaterialModalBottomSheet(
                context: context,
                builder: (context) => BackdropItem(item: state.item),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0))));
          }
        },
        child: child);
  }
}
