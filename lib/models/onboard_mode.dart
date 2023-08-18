import 'package:flutter/material.dart';

import '../widgets/first_onboard.dart';
import '../widgets/second_onboard.dart';

class OnBoardModel {
  final Widget images;
  final String title, description;

  OnBoardModel(
      {required this.images, required this.title, required this.description});
}

List<OnBoardModel> onBoardList = [
  OnBoardModel(
      images: const FirstOnboard(),
      title: 'Find your comfort Food here',
      description:
          'Here you can find a chef or dish for every taste and color enjoy !'),
  OnBoardModel(
      images: const SecondOnboard(),
      title: 'DIDFOOD is Where Your Comfort Food Lives',
      description: 'Enjoy a fast and smooth food delivery at your doorstep'),
];
