import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vasu/utils/secure_storage.dart';

class GoogleAuthService {
  static String? userEmail;

  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        userEmail = userCredential.user?.email;
        return await userCredential.user?.getIdToken();
      }
    } catch (e) {
      print('Error during Google sign-in: $e');
    }
    return null;
  }

  /// Sends the Firebase ID token to the backend for verification.
  static Future<Map<String, dynamic>?> sendTokenToBackend(
      String idToken) async {
    try {
      final response = await http.post(
        Uri.parse('https://setu-2br3.onrender.com/google-login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'token': idToken}),
      );
      print('Sending token to backend');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Save tokens in secure storage if needed
        if (responseData.containsKey('token') &&
            responseData.containsKey('refreshToken')) {
          await SecureStorage.storeToken(responseData['token']);
          await SecureStorage.storeRefreshToken(responseData['refreshToken']);
          print('Token and refresh token stored');
        }

        return responseData; // Return the decoded response
      } else {
        print('Failed to authenticate with backend');
      }
    } catch (e) {
      print('Error during backend authentication: $e');
    }
    return null;
    // return null;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static const String refreshUrl =
      'https://setu-2br3.onrender.com/refresh';

  static Future<void> refreshAuthToken() async {
    final refreshToken = await SecureStorage.getRefreshToken();

    if (refreshToken == null) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(refreshUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        await SecureStorage.storeToken(responseData['token']);
        await SecureStorage.storeRefreshToken(responseData['refreshToken']);
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
  }
}
