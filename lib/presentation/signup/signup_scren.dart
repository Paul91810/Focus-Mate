import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/data/local/user_id.dart';
import 'package:focus_mate/data/models/signup_model.dart';
import 'package:focus_mate/data/repo/signup_repo.dart';
import 'package:focus_mate/data/utils/from_validators.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/main_screen.dart';
import 'package:focus_mate/presentation/widgets/custom_appbutton.dart';
import 'package:focus_mate/presentation/widgets/custom_textfield/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _fromKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emilController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Signup",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                AppSize.commonHeight,
                Center(
                  child: Lottie.asset(
                    'assets/animations/hand_loading.json',
                    height: 100.h,
                  ),
                ),
                AppSize.commonHeight,
                Form(
                    key: _fromKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: nameController,
                            label: 'name',
                            validator: FormValidation.validateName),
                        CustomTextField(
                            controller: emilController,
                            label: 'Email',
                            validator: FormValidation.validateEmail),
                        CustomTextField(
                            controller: passwordController,
                            label: 'Password',
                            validator: FormValidation.validatePassword),
                        CustomTextField(
                          controller: confirmPasswordController,
                          label: 'Confirm Password',
                          validator: (value) {
                            return FormValidation.validateConfirmPassword(
                                value, confirmPasswordController.text);
                          },
                        ),
                      ],
                    )),
                AppSize.commonHeight,
                CustomAppButton(
                  buttonSize: Size(double.infinity, 45.h),
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onPressed: () async {
                    if (_fromKey.currentState!.validate()) {
                      await _signup(
                          name: nameController.text,
                          email: emilController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          context: context);
                    }
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
                  onPressed: () {
                    ;
                  },
                ),
                AppSize.commonHeight,
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

  Future<void> _signup(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context}) async {
    Signup signup = Signup(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword);
    SignupRepo repo = SignupRepo();
    repo.signupUser(signup).then(
      (value) {
        if (value!.message == "Signup successful") {
          UserId.storeUserId(value.userId!);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
            (route) => false,
          );
        }
      },
    );
  }
}
