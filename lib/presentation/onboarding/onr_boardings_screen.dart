import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/presentation/widgets/custom_appbutton.dart';
import 'package:focus_mate/presentation/signup/signup_scren.dart';

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

            AppSize.commonHeight,

            Text(
              'Boost your productivity with\nsmart task planning, daily\nmotivation, and more.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),
            AppSize.commonHeight,
            CustomAppButton(
              buttonSize: Size(250.w, 30.h),
              backGroundcolor: AppColors.kSecondaryColor,
              child: Text("Get Started", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await precacheImage(
                  const Svg('assets/images/signup_backgroundimage.svg'),
                  context,
                );
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
