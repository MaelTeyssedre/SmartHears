import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthears_mobile/modules/onboarding/bottom_button.dart';
import 'package:smarthears_mobile/modules/onboarding/explanation.dart';

final List<ExplanationData> data = [
  ExplanationData(
      description: "onboarding.slide1-description",
      title: "onboarding.slide1-title",
      localImageSrc: "assets/images/1.svg",
      backgroundColor: const Color(0xFFD3AF5F)),
  ExplanationData(
      description: "onboarding.slide2-description",
      title: "onboarding.slide2-title",
      localImageSrc: "assets/images/2.svg",
      backgroundColor: const Color(0xFFB99953)),
  ExplanationData(
      description: "onboarding.slide3-description",
      title: "onboarding.slide3-title",
      localImageSrc: "assets/images/3.svg",
      backgroundColor: const Color(0xFF9E8347)),
  ExplanationData(
      description: "onboarding.slide4-description",
      title: "onboarding.slide4-title",
      localImageSrc: "assets/images/4.svg",
      backgroundColor: const Color(0xFF846D3B)),
  ExplanationData(
      description: "onboarding.slide5-description",
      title: "onboarding.slide5-title",
      localImageSrc: "assets/images/5.svg",
      backgroundColor: const Color(0xFF6A5730))
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Container(
      color: data[_currentIndex].backgroundColor,
      child: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(16),
              color: data[_currentIndex].backgroundColor,
              alignment: Alignment.center,
              child: Column(children: [
                Expanded(
                    child: Column(children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                          alignment: Alignment.center,
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              controller: _controller,
                              onPageChanged: (value) =>
                                  setState(() => _currentIndex = value),
                              children: data
                                  .map((e) => ExplanationPage(data: e))
                                  .toList()))),
                  Expanded(
                      flex: 1,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        data.length,
                                        (index) =>
                                            createCircle(index: index)))),
                            BottomButtons(
                                currentIndex: _currentIndex,
                                dataLength: data.length,
                                controller: _controller)
                          ]))
                ]))
              ]))));

  createCircle({required int index}) => AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.only(right: 4),
      height: 5,
      width: _currentIndex == index ? 15 : 5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(3)));
}
