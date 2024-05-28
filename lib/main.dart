import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/login/login_page.dart';
import 'package:portal_eclb/view/admin/portal_administration_page.dart';
import 'package:portal_eclb/view/portal/page/home/home_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const PortalECLB());
}

class PortalECLB extends StatelessWidget {
  const PortalECLB({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECLB - Espaço Cultural Luciano Bastos',
      initialRoute: "/",
      routes: {
        "/" : (context) => new LoginPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
    );
  }
}


