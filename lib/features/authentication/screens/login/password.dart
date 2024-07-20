import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flighterr/features/authentication/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginWithPassword extends StatefulWidget {
  const LoginWithPassword({super.key});

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void _onNextPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = await prefs.getString('email');
      final password = passwordController.text;

      if (email != null) {
        final data = {'email': email, 'password': password};

        print(data);

        final response = await http.post(
          Uri.parse(
              'https://flightter-api-node-v1.onrender.com/api/v1/auth/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        );

        // Print out the response from the server
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          final String errorMessage =
              responseBody['message'] ?? 'Login Successful';

          final String? token = responseBody['token'];

          if (token != null) {
            prefs.setString('token', token);

            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Success',
                message: errorMessage,
                contentType: ContentType.success,
              ),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);

            context.push('/');
          }
        } else {
          final String errorMessage =
              responseBody['msg'] ?? 'Failed to login. Please try again.';

          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Error',
              message: errorMessage,
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      } else {
        // Handle missing data in SharedPreferences
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Missing required information.')),
        // );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(title: 'Login'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: 'Enter your  \n',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'password',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ])),
                    const SizedBox(height: 20),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Color(0xFF999999)),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 0.5),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please input a password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: _onNextPressed,
                        child: _isLoading
                            ? SpinKitCircle(
                                color: Colors.white,
                                size: 20.0,
                              )
                            : Text(
                                'Next',
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
            ],
          ),
        ),
      ),
    ));
  }
}
