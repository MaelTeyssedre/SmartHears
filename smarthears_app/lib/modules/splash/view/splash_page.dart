import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const SplashPage());

  @override
  Widget build(BuildContext context) => Material(
      color: const Color.fromRGBO(48, 48, 48, 1),
      child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 15, right: 15),
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height / 2.2),
            const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(197, 172, 104, 1))))
          ])));
}
