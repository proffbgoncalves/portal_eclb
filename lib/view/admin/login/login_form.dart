import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/portal_administration_page.dart';

class LoginForm extends StatefulWidget {

  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 400,
      child: new Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0,5)
              )
            ],
            color: Colors.white
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, // This line is important to ensure the form takes minimal space
            children: <Widget>[
              Image.asset("assets/images/logo_eclb.png"),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o usuário';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe a senha";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 58, 0, 100),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pushReplacementNamed(context, "/admin");
                      }
                    },
                    child: Text('Acessar'),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(240, 246, 239, 100),
                      foregroundColor: Color.fromRGBO(9, 65, 0, 100),
                      overlayColor: Color.fromRGBO(0, 58, 0, 100),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {

                      }
                    },
                    child: Text('Cancelar'),
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
