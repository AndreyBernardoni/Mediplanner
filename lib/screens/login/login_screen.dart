import 'package:flutter/material.dart';
import 'package:mediplanner/screens/login/widgets/login_screen_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: LoginFormWidget(),
        ),
      ),
    );
  }
}
