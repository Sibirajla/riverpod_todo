import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/common/res/colors.dart';
import 'package:riverpod_todo/common/widgets/fading_text.dart';
import 'package:riverpod_todo/common/widgets/white_space.dart';
import 'package:riverpod_todo/features/onboarding/widgets/FirstPage.dart';
import 'package:riverpod_todo/features/onboarding/widgets/second_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';






//OnBoardingScreen
// Page 1
// Image
//title
//subtitle
//Page 2
//skip
//swipe_indicator

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: const [FirstPage(), SecondPage()],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap:() {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    },
                    child: const Row(
                      children: [
                        //button
                        Icon(
                          Ionicons.chevron_forward_circle,
                          size: 30,
                          color: Colours.light,
                        ),
                        WhiteSpace(height: 5,),
                        FadingText(
                          'Skip',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          colour: Colours.light,
                        ),
                      ],
                    ),
                  ),
                  // swipe Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                        dotHeight: 12,
                        spacing: 10,
                        dotColor: Colours.yellow.withOpacity(0.5),
                        activeDotColor: Colours.light),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
