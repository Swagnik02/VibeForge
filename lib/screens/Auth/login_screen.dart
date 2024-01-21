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
        backgroundColor: Color(0xFF1F1F1F),
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
                      color: Color(0xFF353334),
                    ),
                    height: Get.height / 2,
                    child: Container(
                      // inner container for tint
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepPurple.shade800.withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Login',
                                    style: Get.textTheme.headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          Column(
                            children: [
                              _custTextField(
                                fieldController: controller.usernameController,
                                labelText: 'Username',
                              ),
                              _custTextField(
                                fieldController: controller.emailController,
                                labelText: 'E-mail',
                              ),
                              _custTextField(
                                fieldController: controller.mobileController,
                                labelText: 'Mobile',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                child: Text('Login'),
                                onPressed: () => controller.login(),
                              ))
                            ],
                          )
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

class _custTextField extends StatelessWidget {
  final TextEditingController fieldController;
  final String labelText;
  const _custTextField({
    super.key,
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
            label: Text(labelText),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          ),
        ),
      ),
    );
  }
}
