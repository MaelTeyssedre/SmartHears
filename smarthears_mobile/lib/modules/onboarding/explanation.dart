import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExplanationData {
  final String title;
  final String description;
  final String localImageSrc;
  final Color backgroundColor;

  ExplanationData(
      {required this.title,
      required this.description,
      required this.localImageSrc,
      required this.backgroundColor});
}


class ExplanationPage extends StatelessWidget {
  final ExplanationData data;

  const ExplanationPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(top: 24, bottom: 16),
          child: SvgPicture.asset(data.localImageSrc,
              height: MediaQuery.of(context).size.height * 0.33,
              alignment: Alignment.center)),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.title,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center)
          ]),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(data.description,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center))
          ]))
    ]);
  }
}
