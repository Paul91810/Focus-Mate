import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:focus_mate/presentation/onboarding/widgets/pageview/page_view.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      'title': "Welcome to Focus Mate",
      'description':
          "Orgnaize yor tasks, focus on your goals and ,and stay productive.",
    },
    
    {
      'title': "Organize Your Tasks",
      'description': "Organize your tasks, focus on your goals and achieve more!",
    },
    {
      'title': "Organize Your Tasks",
      'description': "Easily manage your to-do list and achive your goals.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onboardingData.length,

                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                    log(currentIndex.toString());
                  });
                },
                reverse: false,
                controller: pageController,
                itemBuilder: (BuildContext context, int index) {
                  return OnboardingCard(
                    pagecontroller: pageController,
                   onBoardingLenght: onboardingData.length,
                    index: currentIndex,
                    title: onboardingData[index]['title']!,
                    description: onboardingData[index]['description']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
