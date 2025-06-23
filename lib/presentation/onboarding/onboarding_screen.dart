import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/common/widgets/custom_appbutton.dart';
import 'package:focus_mate/core/common/constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Svg("assets/images/onboardingBackground.svg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 440.h),
            Text(
              'AI-Powered\nProductivity App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            AppConstants.commonHeight,

            Text(
              'Boost your productivity with\nsmart task planning, daily\nmotivation, and more.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),
            AppConstants.commonHeight,
            CustomAppButton(
              buttonSize: Size(250.w, 30.h),
              backGroundcolor: AppConstants.kSecondaryColor,
              child: Text("Get Started", style: TextStyle(color: Colors.white)),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
