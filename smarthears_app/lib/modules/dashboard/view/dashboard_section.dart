import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smarthears_app/models/item.dart';
import 'package:smarthears_app/models/theme.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({Key? key, required this.items, required this.title}) : super(key: key);

  final List<Item> items;
  final String title;

  @override
  Widget build(BuildContext context) => Column(children: [
        Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(padding: const EdgeInsets.all(8), child: Text(title, style: Theme.of(context).textTheme.headline5))),
        Row(children: [Expanded(child: DashboardSectionItems(items: items, title: title))])
      ]);
}

class DashboardSectionItems extends StatelessWidget {
  const DashboardSectionItems({Key? key, required this.items, required this.title}) : super(key: key);
  final List<Item> items;
  final String title;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 150,
      width: 130,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int i) => DashboardSectionItemDisplay(item: items[i], title: title)));
}

class DashboardSectionItemDisplay extends StatelessWidget {
  const DashboardSectionItemDisplay({Key? key, required this.item, required this.title}) : super(key: key);
  final Item item;
  final String title;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () {},
      child: Container(
          height: 120,
          width: 100,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.only(right: 2, left: 2, top: 2, bottom: 2),
          child: Stack(children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))))),
            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 2),
                  child: ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(height: 95, imageUrl: item.logoUrl))),
              Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ShaderMask(
                          shaderCallback: shaderCallback, child: Text(item.title, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center))))
            ])
          ])));
}

// Text(item.title,
//                           overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2)