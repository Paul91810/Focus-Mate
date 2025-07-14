import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/presentation/onboarding/on_boardings_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: FutureBuilder(
        future: _gotoNextScreen(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: Svg("assets/images/applogo.svg"),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              color: AppColors.kWhite,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _gotoNextScreen(BuildContext context) async {
    Future.delayed(Duration(seconds: 3), () async {
      if (!context.mounted) return;
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
        (route) => false,
      );
    });
  }
}
