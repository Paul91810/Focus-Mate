import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/presentation/signup/signup_scren.dart';
import 'package:focus_mate/presentation/widgets/custom_appbutton.dart';
import 'package:lottie/lottie.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String description;
  final int index;
  final int onBoardingLenght;
  final PageController pagecontroller;

  const OnboardingCard({
    super.key,
    required this.title,
    required this.description,
    required this.index,
    required this.onBoardingLenght,
    required this.pagecontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .5,
      color: AppColors.kSecondryColor,
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 140.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.height20,
            Center(
              child: Lottie.asset(
                'assets/animations/on_boarding.json',
                height: 140.h,
              ),
            ),

            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            AppSize.height20,
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
            AppSize.height20,
            CustomAppButton(
              buttonSize: Size(250.w, 40.h),
              backGroundcolor: AppColors.kButtonBlue,
              child: Text(
                index == 2 ? "Get Started" : "Next",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () async {
                if (index < onBoardingLenght - 1) {
                  pagecontroller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
