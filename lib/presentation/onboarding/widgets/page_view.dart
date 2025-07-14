import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/presentation/login/login_screen.dart';
import 'package:focus_mate/presentation/widgets/custom_appbutton.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingCard extends StatefulWidget {
  const OnboardingCard({super.key});

  @override
  State<OnboardingCard> createState() => _OnboardingCardState();
}

class _OnboardingCardState extends State<OnboardingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      'title': "Welcome to Focus Mate",
      'description':
          "Orgnaize yor tasks, focus on your goals and ,and stay productive.",
    },
    {
      'title': "Organize Your Tasks",
      'description': "Easily manage your to-do list and achive your goals.",
    },

    {
      'title': "Organize Your Tasks",
      'description':
          "Organize your tasks, focus on your goals and achieve more!",
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 100),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: onboardingData.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 130.h,
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: SweepGradient(
                      startAngle: 0.0,
                      endAngle: 6.28,
                      colors: [
                        Colors.purple,
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.purple,
                      ],
                      transform: GradientRotation(_controller.value * 3.28),
                    ),
                  ),
                  child: Card(
                    color: AppColors.kSecondryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Lottie.asset(
                              'assets/animations/on_boarding.json',
                              height: 140.h,
                            ),
                          ),
                          Text(
                            onboardingData[index]['title']!,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          AppSize.height20,
                          Text(
                            onboardingData[index]['description']!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          AppSize.height20,
                          Row(
                            children: [
                              index == 0
                                  ? SizedBox()
                                  : Expanded(
                                      child: CustomAppButton(
                                        buttonSize: Size(100.w, 30.h),
                                        backGroundcolor: AppColors.kButtonBlue,
                                        child: Text(
                                          "Back",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge,
                                        ),
                                        onPressed: () async {
                                          pageController.previousPage(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                      ),
                                    ),
                              SizedBox(width: 9.w),
                              Expanded(
                                child: CustomAppButton(
                                  buttonSize: index == 0
                                      ? Size(100.w, 40.h)
                                      : Size(100.w, 30.h),
                                  backGroundcolor: AppColors.kButtonBlue,
                                  child: Text(
                                    index == 2 ? "Get Started" : "Next",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  onPressed: () async {
                                    if (index < onboardingData.length - 1) {
                                      pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 90.h,
          child: SmoothPageIndicator(
            controller: pageController,
            count: onboardingData.length,
            effect: WormEffect(
              dotHeight: 8.h,
              dotWidth: 8.w,
              activeDotColor: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
