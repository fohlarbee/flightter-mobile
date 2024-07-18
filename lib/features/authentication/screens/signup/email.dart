import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flighterr/features/authentication/widgets/checkbox.dart';
import 'package:flighterr/features/authentication/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({super.key});

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _checkBoxValue = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _saveEmail() async {
    if (!_checkBoxValue) {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Please agree to the terms and conditions',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);

      final url = 'https://flightter-api-node-v1.onrender.com/api/v1/auth/otp';

      // print(email);

      final response = await http.post(Uri.parse(url), body: {"email": email});

      print(response.body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);

        context.push('/otp');
      } else {
        final responseBody = jsonDecode(response.body);
        final message =
            responseBody['mssg'] ?? 'Failed to Sign up, please try again';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          children: [
            TopBar(
              title: 'Sign Up',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Color(0xFF999999)),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0.5),
                          ),
                          suffixIcon: _emailController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _emailController.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedCheckbox(
                    value: _checkBoxValue,
                    onChanged: (bool newValue) {
                      setState(() {
                        _checkBoxValue = newValue;
                      }); // Handle checkbox state change
                      //print('Checkbox state: $newValue');
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                        'Get trending content, newsletters, promotions, recommendations, and account updates sent to your email'),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Container(
                child: Text(
                    'Your email address may be used to connect you to people you may know, improve ads, and more, depending on your settings. Learn more'),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
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
    ));
  }
}
