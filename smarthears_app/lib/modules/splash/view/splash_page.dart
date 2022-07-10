import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(builder: (_) => const SplashPage());

  @override
  Widget build(BuildContext context) => Material(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 15, right: 15),
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height / 2.2),
            Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary)))
          ])));
}
