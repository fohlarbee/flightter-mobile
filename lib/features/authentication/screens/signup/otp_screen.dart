import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flighterr/features/authentication/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _pinController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pinController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _saveEmail() async {
    setState(() {
      _isLoading = true;
    });

    //print(_pinController.text);

    final url =
        'https://flightter-api-node-v1.onrender.com/api/v1/auth/otp/verify';
    final otp = _pinController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = await prefs.getString('email');
    final data = {
      'email': email,
      'otp': otp,
    };

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('OTP verified: $responseBody');

      context.push('/birthday-screen');
    } else {
      final responseBody = jsonDecode(response.body);
      final message =
          responseBody['mssg'] ?? 'Failed to verify OTP. Please try again.';
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: message,
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    setState(() {
      _isLoading = false;
    });

    // context.push('/birthday-screen');
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      textStyle: TextStyle(fontSize: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2)),
      ),
    );
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TopBar(
                title: 'Sign Up',
              ),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Pinput(
                    length: 6,
                    controller: _pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color(0xFF2400FF),
                      ),
                    ))),
                  )),
              const SizedBox(height: 20),
              Container(
                height: 50,
                child: TextButton(
                  onPressed: _isLoading ? null : _saveEmail,
                  child: _isLoading
                      ? SpinKitCircle(
                          color: Colors.white,
                          size: 20.0,
                        )
                      : Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF2400FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
