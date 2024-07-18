import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class GoogleAuthServices {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  Future<void> signInWithFacebook() async {
    try {
      // Trigger the Facebook login process
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final accessToken = await FacebookAuth.instance.accessToken;

        if (accessToken != null) {
          _accessToken = loginResult.accessToken!;
          final userData = await FacebookAuth.instance.getUserData();
          _userData = userData;
        }
      } else {
        // Handle Facebook login failure
        throw FirebaseAuthException(
          code: 'Facebook Login Failed',
          message:
              loginResult.message ?? 'The Facebook login was not successful.',
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication exceptions
      print('Firebase Auth Exception: ${e.message}');
      throw e; // rethrow the exception
    } catch (e) {
      // Handle other exceptions
      print('Other Exception: $e');
      throw e; // rethrow the exception
    }
  }
}
