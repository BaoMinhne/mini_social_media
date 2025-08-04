import 'package:flutter/material.dart';
import 'package:mini_social_media/components/my_button.dart';
import 'package:mini_social_media/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap,
  });

  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login methods
  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(
                height: 25,
              ),

              // app name
              Text(
                "S O C I A L - M E D I A",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // email text field
              MyTextfield(
                hintText: "Email...",
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(
                height: 15,
              ),

              // pass word
              MyTextfield(
                hintText: "Password...",
                obscureText: true,
                controller: passwordController,
              ),

              const SizedBox(
                height: 15,
              ),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              // sign in button
              MyButton(text: "Login", onTap: login),

              const SizedBox(
                height: 20,
              ),
              // don't have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register Here!!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
