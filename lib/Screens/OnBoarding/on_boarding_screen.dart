import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_marko/Screens/login/login_screen.dart';
import 'package:super_marko/generated/assets.dart';
import 'package:super_marko/model/onBoarding/on_boarding_model.dart';
import 'package:super_marko/network/cache_helper.dart';
import 'package:super_marko/shared/components/buttons.dart';
import 'package:super_marko/shared/components/custom_painter.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: Assets.imagesOnBoarding1,
      text: 'Online Shopping',
      title: 'Best Way to shop',
      body: 'And get the best deals',
    ),
    OnBoardingModel(
      image: Assets.imagesOnBoarding2,
      text: 'Harry Up Right',
      title: 'Now until it\'s',
      body: 'Too late',
    ),
    OnBoardingModel(
      image: Assets.imagesOnBoarding3,
      text: 'Order Online',
      title: 'Make an order sitting on a sofa',
      body: 'pay and choose online',
    ),
    OnBoardingModel(
      image: Assets.imagesBackground,
      text: 'Order Online',
      title: 'Make an order sitting on a sofa',
      body: 'pay and choose online',
    ),
    OnBoardingModel(
      image: Assets.imagesOnlinePana,
      text: 'Order Online',
      title: 'Make an order sitting on a sofa',
      body: 'pay and choose online',
    ),
    OnBoardingModel(
      image: Assets.imagesOnlineShopping,
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
      appBar: AppBar(
        elevation: 0,
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
            color: AppMainColors.orangeColor,
            context: context,
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: Size(400, (300 * 1.688).toDouble()),
            painter: RPSCustomPainter(),
          ),
          Column(
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
                  itemBuilder: (context, index) => OnBoardingItem(
                    onBoardingModel: boarding[index],
                  ),
                  itemCount: boarding.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).r,
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: boarding.length,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        dotColor: AppMainColors.greyColor,
                        activeDotColor: AppMainColors.orangeColor,
                        radius: 20,
                        spacing: 6,
                        expansionFactor: 4,
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      child: Icon(
                        IconBroken.Arrow___Right_2,
                        size: 35.sp,
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
              ),
            ],
          ),
        ],
      ),
    );
  }

// Widget buildBoardingItem(OnBoardingModel model) => Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SvgPicture.asset(
//           model.image,
//           height: 250.h,
//           width: double.infinity,
//           fit: BoxFit.fill,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20).r,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Text(
//                   model.text,
//                   style: GoogleFonts.pacifico(
//                     fontSize: 40.sp,
//                     fontWeight: FontWeight.w900,
//                     color: AppMainColors.orangeColor,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30.h),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     model.title,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineSmall!
//                         .copyWith(
//                             fontWeight: FontWeight.w900,
//                             color: AppMainColors.whiteColor),
//                   ),
//                   Text(
//                     model.body,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineSmall!
//                         .copyWith(
//                             fontWeight: FontWeight.w900,
//                             color: AppMainColors.whiteColor),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
}

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.onBoardingModel});

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          onBoardingModel.image,
          height: 250.h,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  onBoardingModel.text,
                  style: GoogleFonts.pacifico(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w900,
                    color: AppMainColors.orangeColor,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    onBoardingModel.title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppMainColors.whiteColor),
                  ),
                  Text(
                    onBoardingModel.body,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppMainColors.whiteColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
