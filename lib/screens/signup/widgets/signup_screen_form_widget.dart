import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/signup_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();

    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: controller.name,
            decoration: const InputDecoration(
              label: Text("Nome"),
            ),
          ),
          TextFormField(
            controller: controller.email,
            decoration: const InputDecoration(
              label: Text("Email"),
            ),
          ),
          TextFormField(
            controller: controller.password,
            decoration: const InputDecoration(
              label: Text("Senha"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                SignUpController.instance.registerUser(
                  controller.email.text.trim(),
                  controller.password.text.trim(),
                  controller.name.text.trim(),
                );
              }
            },
            child: const Text("Cadastrar"),
          ),
        ],
      ),
    );
  }
}
