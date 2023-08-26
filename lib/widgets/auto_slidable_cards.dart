import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AutoSlidableCards extends StatefulWidget {
  AutoSlidableCards({super.key});

  @override
  State<AutoSlidableCards> createState() => _AutoSlidableCardsState();
}

class _AutoSlidableCardsState extends State<AutoSlidableCards> {
  final myImages = [
    Image.asset('assets/images/Promo Advertising.png'),
    Image.asset('assets/images/Promo Advertising (1).png'),
    Image.asset('assets/images/Promo Advertising (2).png'),
    Image.asset('assets/images/Promo Advertising (3).png'),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
                items: myImages,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 200,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayInterval: Duration(seconds: 3),
                  enableInfiniteScroll: true,
                  aspectRatio: 2,
                  onPageChanged: (index, reason) {
                    setState(() {});
                    currentIndex = index;
                  },
                ))
          ],
        ),
      ),
    );
  }
}
