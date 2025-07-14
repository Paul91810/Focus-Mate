
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/main_screen.dart';
import 'package:focus_mate/presentation/widgets/custom_appbutton.dart';
import 'package:focus_mate/presentation/widgets/custom_textfield/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emilController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FocusMate",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                AppSize.height20,
                Center(
                  child: Lottie.asset(
                    'assets/animations/hand_loading.json',
                    height: 180.h,
                  ),
                ),
                AppSize.commonHeight,
                CustomTextField(
                  controller: emilController,
                  label: 'Email',
                  validator: (value) {
                    // log(value);
                    return null;
                  },
                ),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  validator: (value) {
                    // log(value);
                     return null;
                  },
                ),
                AppSize.commonHeight,
                CustomAppButton(
                  buttonSize: Size(double.infinity, 45.h),
                  child: Text(
                    'Log in',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                ),
                AppSize.height20,
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: Colors.white, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Expanded(
                      child: Divider(thickness: 1, color: Colors.white),
                    ),
                  ],
                ),
                AppSize.height20,
                CustomAppButton(
                  bordersideColor: Colors.grey.shade600,
                  backGroundcolor: AppColors.kPrimaryColor,
                  buttonSize: Size(double.infinity, 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        height: 18.h,
                        image: Svg('assets/images/signupButtonImage.svg'),
                      ),
                      Text(
                        'Sig in with Google',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                AppSize.commonHeight,
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
