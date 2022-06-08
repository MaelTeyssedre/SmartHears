import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class BackdropItem extends StatefulWidget {
  const BackdropItem({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  _BackDropItemState createState() => _BackDropItemState();
}

class _BackDropItemState extends State<BackdropItem> {
  dynamic item;
  bool expand = false;

  void toggleExpand() => setState(() => expand = !expand);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      height: expand ? 500 : 280,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
                onTap: () => toggleExpand(),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  height: 125,
                                  width: 125,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                          height: 100,
                                          imageUrl: item.logoUrl)))),
                          Expanded(
                              flex: 2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(item.name,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6))),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                  icon: const Icon(
                                                      Icons.close_rounded),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  splashColor:
                                                      Colors.transparent,
                                                  splashRadius: 25))
                                        ]),
                                    const SizedBox(height: 10),
                                    Column(children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('random text',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1))),
                                      !expand
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  height: 74,
                                                  child: SingleChildScrollView(
                                                      child: Html(
                                                          data:
                                                              'random text'))))
                                          : Container()
                                    ])
                                  ]))
                        ]))),
            expand
                ? Expanded(
                    child: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                    GestureDetector(
                        onTap: () => toggleExpand(),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Html(data: 'random text')))),
                    const Divider(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, right: 15),
                              child: Text('random text',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary))),
                          Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, right: 15),
                              child: Text('random text',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary))),
                        ])
                    // ? GeolocationList(item: item)
                  ])))
                : Container(),
            const Divider(),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 15, bottom: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 40,
                                child: FutureBuilder<bool>(builder:
                                    (BuildContext context,
                                        AsyncSnapshot<bool> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    return FloatingActionButton(
                                        child: const Icon(Icons.settings),
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) =>
                                                      AlertDialog(
                                                          title: const Text(
                                                              'random text'),
                                                          content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const Text(
                                                                    'random text'),
                                                                TextButton(
                                                                    onPressed: () => showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (BuildContext context) => const AlertDialog(
                                                                            content: Text(
                                                                                'random text'))),
                                                                    child: Text(
                                                                        'random text',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondary)))
                                                              ]),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel'),
                                                                child: Text(
                                                                    'Annuler',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .caption)),
                                                            TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Continue'),
                                                                child: Text(
                                                                    'Continuer',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .button))
                                                          ]));
                                        });
                                  }
                                  return Container();
                                })),
                            // if (item is Exparience) WidgetLikeButton(item: item)
                          ]),
                      Row(children: [
                        Container(
                            height: 60,
                            width: 60,
                            child: FloatingActionButton(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                onPressed: () {},
                                child: const Icon(Icons.play_arrow,
                                    size: 50, color: Colors.black)))
                      ])
                    ]))
          ]));
}
