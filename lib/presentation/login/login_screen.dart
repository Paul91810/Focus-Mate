import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/data/local/store_user_id.dart';
import 'package:focus_mate/data/models/login_model.dart';
import 'package:focus_mate/data/repo/login_repo.dart';
import 'package:focus_mate/data/utils/from_validators.dart';
import 'package:focus_mate/presentation/signup/signup_scren.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/main_screen.dart';
import 'package:focus_mate/presentation/widgets/custom_appbutton.dart';
import 'package:focus_mate/presentation/widgets/custom_textfield/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final from = GlobalKey<FormState>();
    final emilController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
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
                Form(
                  key: from,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: emilController,
                          label: 'Email',
                          validator: FormValidation.validateEmail),
                      CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          validator: FormValidation.validatePassword),
                    ],
                  ),
                ),
                AppSize.commonHeight,
                CustomAppButton(
                  buttonSize: Size(double.infinity, 45.h),
                  child: Text(
                    'Log in',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onPressed: () async {
                    if (from.currentState!.validate()) {
                      await _signup(
                          email: emilController.text,
                          password: passwordController.text,
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
                AppSize.commonHeight,
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ));
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
      {required String email,
      required String password,
      required BuildContext context}) async {
    Login signup = Login(
      email: email,
      password: password,
    );
    Loginrepo repo = Loginrepo();
    await repo.loginUser(signup).then(
      (value) async {
        if (value!.message == "Login successful") {
          await StoreUserId.storeUserId(value.userId!);
          await Navigator.pushAndRemoveUntil(
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
