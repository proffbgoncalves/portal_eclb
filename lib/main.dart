import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/crud/type_of_patrimony/type_of_patrimony_administration_page.dart';
import 'package:portal_eclb/view/admin/home/administration_home_page.dart';
import 'package:portal_eclb/view/admin/login/login_page.dart';
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
        "/admin" : (context) => new AdministrationHomePage(),
        "/admin/type_of_patrimony" : (context) => TypeOfPatrimonyAdministrationPage()
      },
      // theme: ThemeData(
      //   primaryIconTheme: IconThemeData(
      //     color: Color.fromRGBO(8, 58, 0, 100),
      //     opacity: 100,
      //   ),
      //
      //   hoverColor: Color.fromRGBO(8, 58, 0, 0.19),
      //   primaryColor: Color.fromRGBO(8, 58, 0, 100), // Cor primária do aplicativo
      //   listTileTheme: ListTileThemeData(
      //     minTileHeight: 24,
      //     iconColor: Color.fromRGBO(8, 58, 0, 100),
      //     shape: new RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8))
      //     ),
      //     titleTextStyle: new TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 12,
      //       color: Color.fromRGBO(8, 58, 0, 100),
      //     ),
      //   ),
      //   expansionTileTheme: ExpansionTileThemeData(
      //     shape: new RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8))
      //     ),
      //     collapsedShape: new RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8))
      //     ),
      //     textColor: Color.fromRGBO(8, 58, 0, 100),
      //     collapsedTextColor: Color.fromRGBO(8, 58, 0, 100),
      //     collapsedIconColor: Color.fromRGBO(8, 58, 0, 100),
      //     iconColor: Color.fromRGBO(8, 58, 0, 100),
      //   ),
      //   // Definindo o esquema de cores
      //   colorScheme: ColorScheme(
      //     primary: Color.fromRGBO(8, 58, 0, 100),
      //     secondary:  Color.fromRGBO(251, 249, 217, 100),
      //     surface: Colors.white,
      //     background: Colors.white,
      //     error: Colors.red,
      //     onPrimary: Colors.white,
      //     onSecondary:  Color.fromRGBO(251, 249, 217, 100),
      //     onSurface: Colors.black,
      //     onBackground: Colors.black,
      //     onError: Colors.white,
      //     brightness: Brightness.light,
      //   ),
      // ),
    );
  }
}


