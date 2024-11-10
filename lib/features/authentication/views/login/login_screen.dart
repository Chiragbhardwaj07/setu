import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasu/features/authentication/controllers/login_controller.dart';
import 'package:vasu/shared/constants/app_colors.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(AppProportions.padding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                Obx(() => Center(
                      child: Text(
                        loginController.isSigningIn.value
                            ? 'Get Started'.tr
                            : 'Welcome Back!'.tr,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: AppProportions.verticalSpacing / 2),
                  child: Center(
                    child: Obx(() => Text(
                          loginController.isSigningIn.value
                              ? 'by creating a Free Account'.tr
                              : 'Log in to access your account'.tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: AppProportions.verticalSpacing),
                  child: Text(
                    'Phone Number'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                TextField(
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(10),
                  //   FilteringTextInputFormatter.digitsOnly,
                  // ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        emailController.clear();
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.PrimaryColor),
                    ),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/india-flag-icon.png',
                            width: 24,
                            height: 24,
                          ),
                          // SizedBox(width: 8),
                          // Text(
                          //   '+91 ',
                          //   style: Theme.of(context).primaryTextTheme.bodyLarge,
                          // ),
                        ],
                      ),
                    ),
                    hintText: 'abc@gmai.com',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                ),
                SizedBox(height: AppProportions.verticalSpacing),
                Obx(() {
                  return ElevatedButton(
                    onPressed: () {
                      final email = emailController.text;
                      if (emailController.text.isNotEmpty) {
                        loginController.loginUser(email);
                      } else {
                        // Show error if phone number is invalid
                        Get.snackbar(
                          'Invalid email'.tr,
                          'Please enter a valid email.'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: loginController.isLoading.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          )
                        : Text('Get OTP'.tr,
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor)),
                  );
                }),
                SizedBox(height: AppProportions.verticalSpacing),

                // Divider
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppProportions.verticalSpacing),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child:
                              Divider(color: Colors.grey[500], thickness: 2)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppProportions.padding / 2),
                        child: Text(
                          'OR'.tr,
                          style: GoogleFonts.mulish(
                              color: Colors.grey[500],
                              fontSize: AppProportions.bodyFontSize),
                        ),
                      ),
                      Expanded(
                          child:
                              Divider(color: Colors.grey[500], thickness: 2)),
                    ],
                  ),
                ),

                // Google Sign-In button
                Obx(() {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppProportions.verticalSpacing / 2),
                    child: loginController.isGoogleLoading.value
                        ? ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              foregroundColor: AppColors.TextColor,
                            ),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            onPressed: () {
                              loginController.handleGoogleSignIn();
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8, top: 2),
                              child: Image.asset(
                                'assets/icons/google-color-icon.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            label: Text(
                              'Continue with Google'.tr,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                  );
                }),

                Padding(
                  padding: EdgeInsets.all(AppProportions.padding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Text.rich(
                          TextSpan(
                            text: loginController.isSigningIn.value
                                ? 'Already Have an account? '.tr
                                : 'Don\'t have an account? '.tr,
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    loginController.toggleSignIn();
                                  },
                                text: loginController.isSigningIn.value
                                    ? 'Login'.tr
                                    : 'Sign Up'.tr,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleSmall,
                              ),
                            ],
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                      }),
                    ],
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
