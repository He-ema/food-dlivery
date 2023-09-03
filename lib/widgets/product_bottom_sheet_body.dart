import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BroductBottomSheetBody extends StatefulWidget {
  const BroductBottomSheetBody(
      {super.key,
      required this.images,
      required this.description,
      required this.brand});
  final List<dynamic> images;
  final String description;
  final String brand;
  @override
  State<BroductBottomSheetBody> createState() => _BroductBottomSheetBodyState();
}

class _BroductBottomSheetBodyState extends State<BroductBottomSheetBody> {
  List<Widget> emptyList = [];
  void createItems(List emptyList) {
    for (int i = 0; i < widget.images.length; i++) {
      emptyList.add(Image.network(widget.images[i]));
    }
  }

  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createItems(emptyList);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.4,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                  items: emptyList,
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
                  )),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Brand : ${widget.brand}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
