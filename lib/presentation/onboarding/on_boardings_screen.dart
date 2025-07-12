import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/presentation/onboarding/widgets/page_view.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FocusMate",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Expanded(
                child: OnboardingCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
