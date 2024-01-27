import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/screens/Auth/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginScreenController controller = Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    return GetBuilder<LoginScreenController>(
      builder: (_) => Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.only(left: 30, right: 30, top: (screenHeight / 20)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // main container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF353334),
                    ),
                    height: Get.height / 2,
                    child: Container(
                      // inner container for tint
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepPurple.shade800.withOpacity(0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: Get.textTheme.headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _CustTextField(
                                fieldController: controller.usernameController,
                                labelText: 'Username',
                              ),
                              _CustTextField(
                                fieldController: controller.emailController,
                                labelText: 'E-mail',
                              ),
                              _CustTextField(
                                fieldController: controller.passwordController,
                                labelText: 'Mobile',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurple.shade500,
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => controller.login(),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurple.shade500,
                                  ),
                                ),
                                child: Text(
                                  'SignUp',
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => controller.signup(),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustTextField extends StatelessWidget {
  final TextEditingController fieldController;
  final String labelText;
  const _CustTextField({
    required this.fieldController,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade100,
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          style: TextStyle(color: Colors.deepPurple.shade900),
          controller: fieldController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            floatingLabelAlignment: FloatingLabelAlignment.center,
            label: Text(labelText),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          ),
        ),
      ),
    );
  }
}
