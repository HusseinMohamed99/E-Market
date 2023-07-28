import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_marko/Screens/login/login_screen.dart';
import 'package:super_marko/model/onBoarding/on_boarding_model.dart';
import 'package:super_marko/network/cache_helper.dart';
import 'package:super_marko/shared/components/buttons.dart';
import 'package:super_marko/shared/components/navigator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/cart.png',
      text: 'Online Shopping',
      title: 'Best Way to shop',
      body: 'And get the best deals',
    ),
    BoardingModel(
      image: 'assets/images/Online_shopping.png',
      text: 'Harry Up Right',
      title: 'Now until it\'s',
      body: 'Too late',
    ),
    BoardingModel(
      image: 'assets/images/Online_pana.png',
      text: 'Order Online',
      title: 'Make an order sitting on a sofa',
      body: 'pay and choose online',
    ),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          const LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        actions: [
          defaultTextButton(
            function: submit,
            text: 'Skip',
            context: context,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrangeAccent,
                    radius: 20.0,
                    spacing: 6,
                    expansionFactor: 4.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(
                    Icons.play_arrow_outlined,
                    size: 35.0,
                  ),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 780,
                        ),
                        curve: Curves.bounceInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image,
              ),
            ),
          ),
          Center(
            child: Text(
              model.text,
              style: GoogleFonts.lobster(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
                color: Colors.deepOrange,
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: GoogleFonts.lobster(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
              ),
              Text(
                model.body,
                style: GoogleFonts.lobster(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      );
}
