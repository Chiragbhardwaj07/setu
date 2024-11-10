import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vasu/features/authentication/controllers/onboarding_controller.dart';
import 'package:vasu/shared/constants/app_colors.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingController controller = Get.find<OnboardingController>();
  // String? phoneNumber = Get.parameters['phone'];
  String? email = Get.parameters['email'];
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (controller.isGoogleSignIn.value) {
      controller.emailController.text = email ?? '';
    }
  }

  @override
  void dispose() {
    // Dispose of FocusNodes
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    dobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.all(AppProportions.padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                SizedBox(height: AppProportions.verticalSpacing),
                Text(
                  'Complete your Profile'.tr,
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
                SizedBox(height: AppProportions.verticalSpacing / 2),
                Text('Tell us more about you'.tr,
                    style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: AppProportions.verticalSpacing),

                TextField(
                  controller: controller.nameController,
                  style: GoogleFonts.mulish(),
                  focusNode: nameFocusNode,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.surface,
                    filled: true,
                    labelText: 'Full Name'.tr,
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person, color: AppColors.PrimaryColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: AppProportions.verticalSpacing),

                Obx(() {
                  return Column(
                    children: [
                      TextField(
                        controller: controller.phoneController,
                        focusNode: phoneFocusNode,
                        style: GoogleFonts.mulish(),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).colorScheme.surface,
                          filled: true,
                          labelText: 'Phone Number'.tr,
                          labelStyle: Theme.of(context).textTheme.bodyLarge,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.phone,
                                color: AppColors.PrimaryColor),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: AppProportions.verticalSpacing),
                      // Non-editable email field
                      AbsorbPointer(
                        child: TextField(
                          controller: controller.emailController,
                          focusNode: emailFocusNode,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.surface,
                            filled: true,
                            labelText: 'Email'.tr,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.mail,
                                  color: AppColors.PrimaryColor),
                            ),
                            border: OutlineInputBorder(),
                            suffixIcon:
                                Icon(Icons.verified, color: Colors.green),
                          ),
                        ),
                      ),

                      // Editable phone number field
                    ],
                  );
                }),

                SizedBox(height: AppProportions.verticalSpacing),

                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                    FocusScope.of(context).unfocus();
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: controller.dobController,
                      focusNode: dobFocusNode,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'Date of Birth (DD-MM-YYYY)'.tr,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.calendar_today,
                              color: AppColors.PrimaryColor),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: GoogleFonts.mulish(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppProportions.verticalSpacing),

                // Submit Button
                Obx(() => ElevatedButton(
                      onPressed: controller.updateUserInfo,
                      child: controller.isUpdating.value
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ))
                          : Text(
                              'Submit'.tr,
                            ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.PrimaryColor),
                    )),
                SizedBox(height: AppProportions.verticalSpacing),

                // Skip Button
                Center(
                  child: TextButton(
                    onPressed: controller.skipOnboarding,
                    child: Text(
                      'Skip'.tr,
                      style: Theme.of(context).primaryTextTheme.titleSmall,
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

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      controller.dobController.text = formattedDate;
    }
  }
}
