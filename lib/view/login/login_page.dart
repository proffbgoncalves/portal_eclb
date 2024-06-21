import 'package:flutter/material.dart';
import 'package:portal_eclb/view/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: LoginForm(),
      ),
    );
  }

}
