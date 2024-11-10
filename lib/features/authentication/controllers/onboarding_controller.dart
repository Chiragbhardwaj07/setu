import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vasu/features/authentication/controllers/language_selection_controller.dart';
import 'package:vasu/utils/secure_storage.dart';

import 'package:vasu/features/authentication/data/models/user_auth_model.dart'; // Assuming this contains the API model for user
import 'package:vasu/features/authentication/data/services/user_local_service.dart';
import 'package:vasu/utils/ui_hepers.dart'; // Local Hive storage service

class OnboardingController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final LanguageSelectionController _languageController = Get.find();


  var isUpdating = false.obs;
  final RxBool isGoogleSignIn = false.obs;
  final storage = FlutterSecureStorage();
  final UserLocalService userLocalService = UserLocalService();

  String? uid; // For Google sign-in

  @override
  void onInit() {
    super.onInit();
    // Check if we're coming from Google or phone sign-in
    if (Get.parameters['isGoogleSignIn'] == 'true') {
      isGoogleSignIn.value = true;
      emailController.text = Get.parameters['email'] ?? '';
      uid = Get.parameters['uid']; // Fetch the uid from parameters
    } else {
      isGoogleSignIn.value = false;
      phoneController.text ="+91${Get.parameters['phone']}"?? ''; // Handle phone number if passed
    }
  }

  Future<void> updateUserInfo() async {
    isUpdating(true);
    String selectedLanguage = _languageController.selectedLanguage.value;

    try {
      // Fetch the token from secure storage
      String? token = await SecureStorage.getAccessToken();
      debugPrint("Token retrieved: $token");

      if (token == null) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: 'No access token found!',
          backgroundColor: Colors.red,
        );
        return;
      }

      // Prepare data for the API call

      final Map<String, dynamic> requestData = {
        "phone": phoneController.text.trim(),
        "name": nameController.text.trim(),
        "dob": dobController.text.trim(),
        "email": emailController.text.trim(),
        "region": "India",
        "language": selectedLanguage,
      };

      // If Google sign-in, include the uid
      if (isGoogleSignIn.value && uid != null) {
        requestData['uid'] = uid; // Include UID in request data
      }

      // Making the API request
      final response = await http.post(
        Uri.parse("https://setu-2br3.onrender.com/update-info-first"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },

        body: jsonEncode(requestData),
      );
      print(phoneController.text);
      print(jsonDecode(response.body)['user']);
      // Handle the response
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(phoneController.text);
print(jsonResponse['user']);
        var user = UserModel.fromJson(jsonResponse['user']);

        // Store user information locally using Hive
        await userLocalService.storeUserInHive(user);

        // Show success message
        UIHelpers.showToast(
          message: 'Logged In',
        );

        // Optionally, navigate to bottom_navbar
        Get.offAllNamed('/bottom_navbar');
      } else {
        final errorResponse = jsonDecode(response.body);
        debugPrint("API Error: ${errorResponse['message']}");

        // Show error message
        UIHelpers.showSnackbar(
          title: 'Update Failed',
          message: 'Unable to update profile. Please try again.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      UIHelpers.showSnackbar(
        title: 'Error',
        message: 'An error occurred: $e',
        backgroundColor: Colors.red,
      );
      debugPrint("Exception: $e");
    } finally {
      isUpdating(false);
    }
  }

  // Function to skip the onboarding
  void skipOnboarding() {
    Get.offAllNamed('/bottom_navbar');
  }
}
