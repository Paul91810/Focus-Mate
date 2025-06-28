import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/presentation/onboarding/onr_boardings_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      body: FutureBuilder(
        future: _gotoNextScreen(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: Svg("assets/images/splashScreen.svg"),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              color: AppColors.kAccentColor,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _gotoNextScreen(BuildContext context) async {
    await precacheImage(
      const Svg('assets/images/onboardingBackground.svg'),
      context,
    );
    Future.delayed(Duration(seconds: 3), () async {
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
        (route) => false,
      );
    });
  }
}
