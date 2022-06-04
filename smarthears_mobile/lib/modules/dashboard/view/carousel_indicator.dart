import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smarthears_mobile/login_screen.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:smarthears_mobile/modules/backdrop_item/bloc/backdrop_item_bloc.dart';
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

Widget headerImage(String url) => CachedNetworkImage(
      imageUrl: url,
    );

GetIt getIt = GetIt.instance;

class CarouselWithIndicator extends StatefulWidget {
  CarouselWithIndicator({required this.data});

  final List<dynamic> data;

  @override
  State<StatefulWidget> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        CarouselSlider(
            items: widget.data.map((i) {
              final theme = Theme.of(context);
              var container = Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: theme.backgroundColor),
                  child: headerImage(i is Header ? i.url : i));
              if (i is Header)
                return GestureDetector(
                    onTap: () async {
                      if (await getIt<AuthRepository>().hasToken())
                        BlocProvider.of<BackdropItemBloc>(context)
                            .add(ShowBackdropEvent(itemType: i.type, objectId: i.objectId));
                      else
                        Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: container);
              return container;
            }).toList(),
            options: CarouselOptions(
                aspectRatio: 1 / 1,
                autoPlayInterval: Duration(seconds: 6),
                viewportFraction: 1,
                enableInfiniteScroll: widget.data.length > 1,
                autoPlay: widget.data.length > 1,
                onPageChanged: (index, reason) => setState(() => _current = index))),
        if (widget.data.length > 1)
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.data.map((url) {
                int index = widget.data.indexOf(url);
                return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? Colors.white : Theme.of(context).splashColor));
              }).toList())
      ]),
      Positioned(
          top: widget.data.length > 1 ? 35 : 0, left: 0, child: Image.asset("assets/images/logo_header.png", width: 80))
    ]);
  }
}
