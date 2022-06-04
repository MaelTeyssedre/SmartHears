import 'package:flutter/material.dart';

import 'package:smarthears_mobile/modules/dashboard/view/dashboard_screen.dart';


class BottomButtons extends StatelessWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {Key? key,
      required this.currentIndex,
      required this.dataLength,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: currentIndex == dataLength - 1
            ? [
                Expanded(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 70.0),
                        child: FlatButton(
                            onPressed: () => Navigator.pushReplacement(
                                context, DashboardScreen.route()),
                            color: Colors.black,
                            height: MediaQuery.of(context).size.height * 0.1,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap, // add this
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide.none),
                            child: Text("onboarding.start-button",
                                style: Theme.of(context).textTheme.button))))
              ]
            : [
                TextButton(
                    onPressed: () => Navigator.pushReplacement(
                        context, DashboardScreen.route()),
                    child: Text("onboarding.skip-button",
                        style: Theme.of(context).textTheme.bodyText2)),
                Row(children: [
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                      child: Text("onboarding.next-button",
                          style: Theme.of(context).textTheme.bodyText1)),
                  Container(
                      alignment: Alignment.center,
                      child: const Icon(Icons.arrow_right_alt,
                          color: Colors.white))
                ])
              ]);
  }
}
