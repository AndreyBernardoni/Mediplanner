import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/login_controller.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formkey = GlobalKey<FormState>();

    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
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
                LoginController.instance.loginUser(
                  controller.email.text.trim(),
                  controller.password.text.trim(),
                );
              }
            },
            child: const Text("Entrar"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offNamed("/signup");
            },
            child: const Text("Não possuo cadastro"),
          ),
        ],
      ),
    );
  }
}
