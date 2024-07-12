import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flighterr/features/authentication/widgets/checkbox.dart';
import 'package:flighterr/features/authentication/widgets/top_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({super.key});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
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
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);

      setState(() {
        _isLoading = false;
      });

      context.go('/login-with-password');
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
              title: 'Login',
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
