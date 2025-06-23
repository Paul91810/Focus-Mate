import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/common/constants.dart';
import 'package:focus_mate/core/common/widgets/custom_appbutton.dart';
import 'package:focus_mate/core/common/widgets/custom_textfield/custom_textfield.dart';

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
              children: [
                Text(
                  "FocusMate",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Image(image: Svg('assets/images/signup_backgroundimage.svg')),
                AppConstants.commonHeight,
                CustomTextField(
                  controller: emilController,
                  label: 'Email',
                  validator: (value) {},
                ),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  validator: (value) {},
                ),
                AppConstants.commonHeight,
                CustomAppButton(
                  buttonSize: Size(double.infinity, 45.h),
                  child: Text('Log in', style: TextStyle(fontSize: 18.sp)),
                  onPressed: () {},
                ),
                AppConstants.commonHeight,
                Row(
                  children: [
                    const Expanded(
                      
                      child: Divider(
                        color: Colors.black26,
                        thickness: 1)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1,color: Colors.black26,)),
                  ],
                ),
                CustomAppButton(
                  bordersideColor: Colors.grey.shade400,
                  backGroundcolor: AppConstants.kPrimaryColor,
                  buttonSize: Size(double.infinity, 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        height: 20.h,
                        image: Svg('assets/images/signupButtonImage.svg'),
                      ),
                      Text(
                        'Sig in with Google',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                AppConstants.commonHeight,
                TextButton(onPressed: () {}, child: Text('Sign Up',style: TextStyle(
                  fontSize: 14.h,
                  color: AppConstants.kSecondaryColor),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
