import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:smarthears_app/models/item.dart';
import 'package:flutter/material.dart';

class BackdropItem extends StatefulWidget {
  const BackdropItem({Key? key, required this.item, required this.itemType}) : super(key: key);

  final Item item;
  final ItemType itemType;

  @override
  State<BackdropItem> createState() => _BackdropItemState();
}

class _BackdropItemState extends State<BackdropItem> {
  Item? item;
  bool expand = false;

  @override
  void initState() {
    item = widget.item;
    super.initState();
  }

  void toggleExpand() => setState(() => expand = !expand);

  @override
  Widget build(BuildContext context) => (item != null)
      ? AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          height: 500,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
            GestureDetector(
                onTap: () => toggleExpand(),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                  height: 125,
                                  width: 125,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(height: 100, imageUrl: item!.logoUrl)))),
                          Expanded(
                              flex: 2,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Flexible(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(item!.title,
                                              maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black)))),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          icon: const Icon(Icons.close_rounded),
                                          onPressed: () => Navigator.pop(context),
                                          color: Colors.black,
                                          splashColor: Colors.black,
                                          splashRadius: 25))
                                ])
                              ]))
                        ])))
          ]))
      : Container();
}
