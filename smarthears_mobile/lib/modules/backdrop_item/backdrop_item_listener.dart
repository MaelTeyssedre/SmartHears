import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:smarthears_mobile/modules/backdrop_item/backdrop_item.dart';
import 'package:smarthears_mobile/modules/backdrop_item/bloc/backdrop_item_bloc.dart';

class BackdropItemListener extends StatelessWidget {
  BackdropItemListener(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: BlocProvider.of<BackdropItemBloc>(context),
        listener: (context, state) async {
          if (state is ShowBackdropItem) {
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
