import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vasu/app/error_handling/app_exceptions.dart';
import 'package:vasu/utils/secure_storage.dart';
import 'package:sms_autofill/sms_autofill.dart';

class AuthRepository {
  final String loginUrl = 'https://snaket-backend-4.onrender.com/login';
  final String verifyOtpUrl =
      'https://snaket-backend-4.onrender.com/verify-otp';
  final String refreshTokenUrl =
      'https://snaket-backend-4.onrender.com/refresh';
  final String googleSignInUrl =
      'https://snaket-backend-4.onrender.com/google-signin';
  final String logoutUrl = 'https://snaket-backend-4.onrender.com/logout';

  Future<Map<String, dynamic>> login(String phoneNumber) async {
    var aid = await SmsAutoFill().getAppSignature;
    print(aid);
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phoneNumber, 'aid': aid}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw BadRequestException('Login failed');
      }
    } on SocketException {
      throw NoInternetException(
          'No internet connection. Please check your connection and try again.');
    } catch (e) {
      throw FetchDataException('Failed to communicate with server');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(verifyOtpUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw BadRequestException('OTP verification failed');
      }
    } on SocketException {
      throw NoInternetException(
          'No internet connection. Please check your connection and try again.');
    } catch (e) {
      throw FetchDataException('Failed to communicate with server');
    }
  }

  Future<Map<String, dynamic>> sendGoogleToken(String idToken) async {
    try {
      final response = await http.post(
        Uri.parse(googleSignInUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_token': idToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw BadRequestException('Google Sign-In failed');
      }
    } on SocketException {
      throw NoInternetException(
          'No internet connection. Please check your connection and try again.');
    } catch (e) {
      throw FetchDataException('Failed to communicate with server');
    }
  }

  Future<Map<String, dynamic>> refreshTokens() async {
    final String? refreshToken = await SecureStorage.getRefreshToken();

    if (refreshToken == null) {
      throw UnauthorizedException('No refresh token available');
    }

    try {
      final response = await http.post(
        Uri.parse(refreshTokenUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': refreshToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw UnauthorizedException('Token refresh failed');
      }
    } on SocketException {
      throw NoInternetException(
          'No internet connection. Please check your connection and try again.');
    } catch (e) {
      throw FetchDataException('Failed to communicate with server');
    }
  }

  Future<void> logout(String? token) async {
    try {
      final response = await http.post(
        Uri.parse(logoutUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode != 200) {
        throw BadRequestException('Logout failed');
      }
    } on SocketException {
      throw NoInternetException(
          'No internet connection. Please check your connection and try again.');
    } catch (e) {
      throw FetchDataException('Failed to communicate with server');
    }
  }
}
