// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/signup_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formkey = GlobalKey<FormState>();

    return Form(
      key: formkey,
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
          Obx(
            () => CheckboxListTile(
              title: const Text("Sou idoso"),
              value: controller.isOlderly.value,
              onChanged: (value) {
                controller.isOlderly.value = value!;
                print(controller.isOlderly.value);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                SignUpController.instance.registerUser(
                  controller.email.text.trim(),
                  controller.password.text.trim(),
                  controller.name.text.trim(),
                  controller.isOlderly.value,
                );
              }
            },
            child: const Text("Cadastrar"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offNamed("/login");
            },
            child: const Text("Já tenho cadastro"),
          ),
        ],
      ),
    );
  }
}
