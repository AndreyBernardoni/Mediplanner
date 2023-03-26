import 'package:flutter/material.dart';

import 'widgets/signup_screen_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SignUpFormWidget(),
        ),
      ),
    );
  }
}
