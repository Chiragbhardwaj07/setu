import 'dart:async'; // Import for Timer
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vasu/features/authentication/controllers/login_controller.dart';
import 'package:vasu/shared/constants/app_colors.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:vasu/shared/constants/app_proportions.dart';
import 'package:vasu/utils/ui_hepers.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with CodeAutoFill {
  final LoginController loginController = Get.find<LoginController>();
  final TextEditingController otpController = TextEditingController();
  String otpCode = "";
  String phoneNumber = "";
  Timer? timer; // Timer variable
  RxInt countdown = 45.obs; // Countdown using GetX
  final FocusNode otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    listenForCode();
    phoneNumber = Get.parameters['phoneNumber'] ?? '';
    startTimer(); // Start the timer
  }

  @override
  void codeUpdated() {
    print(code);
    setState(() {
      otpController.text = code!;
    });
    // if (otpController.text.length == 6) {
    //   _verifyOTP(); // Automatically verify the OTP once auto-filled
    // }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    SmsAutoFill().unregisterListener();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  void startTimer() {
    countdown.value = 45; // Reset countdown to 45 seconds
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdown.value == 0) {
        timer.cancel(); // Stop the timer when it reaches zero
      } else {
        countdown.value--; // Decrease time
      }
    });
  }

  void _verifyOTP() {
    print("***********OTP: ${otpController.text}");
    print(otpController.text);
    final otp = otpController.text;
    if (otp.isNotEmpty && otp.length == 6) {
      loginController.verifyOTP(otp);
    } else {
      UIHelpers.showSnackbar(
        title: 'Error'.tr,
        message: 'Please enter a valid 6-digit OTP.'.tr,
        backgroundColor: Colors.red,
      );
    }
  }

  void _resendOTP() {
    if (countdown.value > 0) return; // Prevent if countdown is still running
    print(phoneNumber);
    otpController.clear();
    loginController
        .loginUser('+' + phoneNumber.trim()); // Call the login API again
    startTimer(); // Restart the timer
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              // key: UniqueKey(),
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppProportions.screenHeight * 0.2),
                Text(
                  'Almost there!'.tr,
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppProportions.verticalSpacing),
                    child: Text.rich(
                        TextSpan(
                          text: 'Enter the OTP sent to your Phone No. '.tr,
                          children: [
                            TextSpan(
                              text: '+${phoneNumber.trim()}',
                              style:
                                  Theme.of(context).primaryTextTheme.titleSmall,
                            ),
                            TextSpan(text: ' for verification.'.tr),
                          ],
                        ),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                SizedBox(height: AppProportions.verticalSpacing),
                Builder(builder: (localContext) {
                  return PinCodeTextField(
                    focusNode: otpFocusNode,
                    appContext: localContext,
                    length: 6,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                    onCompleted: (value) {
                      _verifyOTP(); // Verify OTP when completed
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: AppProportions.screenHeight * 0.08,
                      fieldWidth: AppProportions.screenHeight * 0.06,
                      activeFillColor: Theme.of(context).colorScheme.surface,
                      inactiveColor: Colors.grey,
                      disabledColor: Colors.grey,
                      activeColor: AppColors.PrimaryColor,
                      selectedColor: AppColors.PrimaryColor,
                      selectedFillColor: Theme.of(context).colorScheme.surface,
                      inactiveFillColor: Theme.of(context).colorScheme.surface,
                      errorBorderColor: Colors.red,
                    ),
                    enableActiveFill: true,
                  );
                }),
                SizedBox(height: AppProportions.verticalSpacing),
                Obx(() {
                  return ElevatedButton(
                    onPressed: _verifyOTP,
                    child: loginController.isLoading.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          )
                        : Text('Verify'.tr),
                  );
                }),
                SizedBox(height: 20),
                Center(
                  child: Obx(() => Text.rich(
                        TextSpan(
                            text: 'Didn\'t get the OTP? '.tr,
                            children: [
                              TextSpan(
                                text: 'Resend'.tr,
                                style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.bold,
                                  color: countdown.value > 0
                                      ? Colors.grey // Disabled color
                                      : AppColors.PrimaryColor, // Enabled color
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (countdown.value == 0) {
                                      _resendOTP();
                                    }
                                  },
                              ),
                            ],
                            style: Theme.of(context).textTheme.bodyLarge),
                      )),
                ),
                SizedBox(height: 8),
                Obx(() => Center(
                        child: Text.rich(TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            text: 'Request new code in'.tr,
                            children: [
                          TextSpan(text: ' 00:${countdown.value}s'),
                        ])))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
