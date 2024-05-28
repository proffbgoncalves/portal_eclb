import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(251, 249, 217, 100),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}
