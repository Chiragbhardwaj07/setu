import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vasu/features/authentication/data/models/user_auth_model.dart';
import 'package:vasu/features/authentication/data/repository/authrepository.dart';
import 'package:vasu/features/authentication/data/services/google_auth_service.dart';
import 'package:vasu/features/authentication/data/services/user_local_service.dart';
import 'package:vasu/features/authentication/data/services/user_session_servive.dart';
import 'package:vasu/utils/secure_storage.dart';
import 'package:vasu/utils/ui_hepers.dart';

class LoginController extends GetxController {
  RxBool isSigningIn = false.obs;
  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;

  final UserLocalService userLocalService = UserLocalService();
  final AuthRepository authRepository = AuthRepository();
  String? phoneNumber;
  TextEditingController otpController = TextEditingController();

  // 1. Login
  Future<void> loginUser(String phoneNumberInput) async {
    isLoading(true);
    try {
      final response = await authRepository.login(phoneNumberInput);
      debugPrint('Response: $response');
      phoneNumber = phoneNumberInput;
      Get.toNamed('/otp/$phoneNumber');
    } catch (e) {
      UIHelpers.showSnackbar(
        title: 'Login Failed',
        message: 'Unable to login with phone number.',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  // 2. OTP Verification
  Future<void> verifyOTP(String otp) async {
    if (phoneNumber == null) {
      UIHelpers.showSnackbar(
        title: 'Error',
        message: 'Phone number not provided!',
        backgroundColor: Colors.red,
      );
      return;
    }

    isLoading(true);
    try {
      final response = await authRepository.verifyOtp(phoneNumber!, otp);
      final authResponse = AuthResponseModel.fromJson(response);

      if (authResponse.token != null && authResponse.refreshToken != null) {
        await SecureStorage.storeToken(authResponse.token!);
        await SecureStorage.storeRefreshToken(authResponse.refreshToken!);
        await userLocalService.storeUserInHive(authResponse.user);

        final sessionManager = SessionManager();
        await sessionManager.setLoggedIn(true);

        await checkAndHandleTokenExpiration(authResponse.token!);
      }

      if (authResponse.user.firstTime == true) {
        Get.toNamed('/onboarding', parameters: {
          'isGoogleSignIn': 'false',
          'phone': phoneNumber!,
        });
      } else {
        Get.offAllNamed('/bottom_navbar');
      }
    } catch (e) {
      otpController.clear();
      UIHelpers.showSnackbar(
        title: 'OTP Verification Failed',
        message: 'Invalid OTP, please try again.',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  // 3. Google Sign-In
  Future<void> handleGoogleSignIn() async {
    try {
      isGoogleLoading(true);
      String? idToken = await GoogleAuthService.signInWithGoogle();

      if (idToken != null) {
        final response = await GoogleAuthService.sendTokenToBackend(idToken);
        debugPrint('Response: $response');

        if (response != null) {
          // Use a null check or default to false if first_time is null
          bool firstTime = response['user']['first_time'] ?? false;

          String email = response['user']['email'];

          String uid =
              response['user']['uid']; // Extract the uid from the response

          await SecureStorage.storeToken(response['token']);
          await SecureStorage.storeRefreshToken(response['refreshToken']);

          if (firstTime) {
            debugPrint('Navigating to onboarding with email: $email');
            Get.toNamed('/onboarding', parameters: {
              'isGoogleSignIn': 'true',
              'email': email,
              'uid': uid,
            });
          } else {
            Get.offAllNamed('/bottom_navbar');
            UIHelpers.showToast(
              message: 'Logged In',
            );
          }
        }
        isGoogleLoading(false);
      }
    } catch (error) {
      debugPrint('Error during Google sign-in: $error');
      isGoogleLoading(false);
    }
  }

  Future<void> checkAndHandleTokenExpiration(String accessToken) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    debugPrint('Decoded Token: $decodedToken');
    DateTime expiryDate = JwtDecoder.getExpirationDate(accessToken);
    Duration timeToExpiry = expiryDate.difference(DateTime.now());
    Duration refreshDuration = timeToExpiry - Duration(minutes: 1);
    print(refreshDuration);
    print(timeToExpiry);

    if (refreshDuration.isNegative) {
      await refreshTokens();
    } else {
      Future.delayed(refreshDuration, () async {
        await refreshTokens();
      });
    }
  }

  Future<void> refreshTokens() async {
    try {
      print("refresh calling");
      final newTokens = await authRepository.refreshTokens();
      print(newTokens['token']);
      print(newTokens['refreshToken']);
      await SecureStorage.storeToken(newTokens['token']);
      await SecureStorage.storeRefreshToken(newTokens['refreshToken']);
      await checkAndHandleTokenExpiration(newTokens['token']);
    } catch (e) {
      await handleLogout();
    }
  }

  Future<void> handleLogout() async {
    try {
      final userLocalService = UserLocalService();
      final user = await userLocalService.getUserFromHive();
      final token = await SecureStorage.getAccessToken();

      // Clear Google sign-in if signed in through Google
      if (user != null && user.uid != null && user.uid != '') {
        await FirebaseAuth.instance.signOut();
        await GoogleAuthService.signOut();
      }

      // Call logout API
      await authRepository.logout(token);

      // Clear tokens from secure storage
      await SecureStorage.clearTokens();

      await userLocalService.clearUserFromHive();
      // Update session manager and navigate to login screen
      final sessionManager = SessionManager();
      await sessionManager.setLoggedIn(false);

      UIHelpers.showToast(
        message: 'Logged Out',
      );
      Get.offAllNamed('/login');
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  void toggleSignIn() {
    isSigningIn.value = !isSigningIn.value;
  }
}
