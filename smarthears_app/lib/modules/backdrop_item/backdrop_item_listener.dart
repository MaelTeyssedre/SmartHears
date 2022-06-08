import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackdropItemListener extends StatelessWidget {
  const BackdropItemListener({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: BlocProvider.of<BackdropItemBloc>(context),
        listener: (context, state) async {
          if (state is ShowBackdropItem) {
            var isUnlocked =
                await FlutterSecureStorage().read(key: state.item is Exparience ? state.item.id : state.item.uniqueKey);
            showMaterialModalBottomSheet(
                context: context,
                builder: (context) => BackdropItem(
                    isLive: false,
                    item: state.item,
                    isFan: state.type == ItemType.fanArtZone,
                    isSecured: (state.item is Exparience ? state.item.secured : state.item.vip) && isUnlocked == null),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))));
          }
        },
        child: child);
  }
}
