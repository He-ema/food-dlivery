import 'package:flutter/material.dart';
import 'package:food/views/register_view.dart';

import '../models/onboard_mode.dart';
import 'custom_button.dart';

class OnboardingPageView extends StatefulWidget {
  OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (value) {
              currentIndex = value;
              setState(() {});
            },
            itemCount: onBoardList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  onBoardList[index].images,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    onBoardList[index].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 4),
                          blurRadius: 16.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    onBoardList[index].description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 4),
                          blurRadius: 16.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                onBoardList.length,
                (index) => Container(
                      height: 10,
                      width: currentIndex == index ? 25 : 10,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
          ),
        ),
        CustomButton(
          onTap: () {
            currentIndex == onBoardList.length - 1
                ? Navigator.pushNamed(context, RegisterView.id)
                : _controller.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear);
          },
          text: currentIndex == onBoardList.length - 1 ? 'Continue' : 'Next',
        ),
      ],
    );
  }
}
