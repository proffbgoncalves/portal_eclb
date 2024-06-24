import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/crud/typeofpatrimony/types_of_patrimonies_page.dart';
import 'package:portal_eclb/view/admin/home/administration_home_page.dart';
import 'package:portal_eclb/view/login/login_page.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  // await dotenv.load(fileName: "../.env");
  // print(dotenv.env["dbms"]);

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
        "/admin/config/types_of_patrimonies" : (context) => new TypesOfPatrimoniesPage()
      },
      theme: new ThemeData(
        colorScheme: new ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromRGBO(33, 52, 0, 100),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(251, 246, 193, 100),
          onSecondary: Color.fromRGBO(33, 52, 0, 100),
          error: Color.fromRGBO(203, 0, 0, 100),
          onError: Colors.white,
          surface: Color.fromRGBO(233, 235, 230, 100),
          onSurface: Color.fromRGBO(33, 52, 0, 100),
          tertiary: Color.fromRGBO(186, 192, 176, 100),
          onTertiary: Color.fromRGBO(33, 52, 0, 100),
        ),
        textButtonTheme: new TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: new TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(33, 52, 0, 100),
              fontWeight: FontWeight.bold,
            )
          )
        ),
        scaffoldBackgroundColor: Color.fromRGBO(251, 246, 193, 100),
        textTheme: new TextTheme(
          labelLarge: new TextStyle(
            fontSize: 14
          ),
          labelMedium: new TextStyle(
              fontSize: 12
          ),
          labelSmall: new TextStyle(
              fontSize: 12
          ),
          headlineLarge: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          )
        ),
        inputDecorationTheme: new InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Color.fromRGBO(33, 52, 0, 100),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0), // Ajuste da altura,
          filled: true,
          labelStyle: new TextStyle(
            fontSize: 13
          ),
        ),
        elevatedButtonTheme: new ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(33, 52, 0, 100),
            foregroundColor: Colors.white,
            textStyle: new TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),
        hoverColor: Color.fromRGBO(153, 162, 138, 100),
        listTileTheme: new ListTileThemeData(
          minTileHeight: 24,
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          textColor: Color.fromRGBO(33, 52, 0, 100),
          titleTextStyle: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        expansionTileTheme: new ExpansionTileThemeData(
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          collapsedShape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
        ),
        dataTableTheme: new DataTableThemeData(
          headingRowHeight: 32,
          dataRowHeight: 32,
          dividerThickness: 1,
          dataRowColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(255, 255, 255, 0.6)),
          horizontalMargin: 8,
          columnSpacing: 10,
          headingTextStyle: new TextStyle(
            color: Color.fromRGBO(33, 52, 0, 100),
            fontSize: 13,
            fontWeight: FontWeight.bold
          )
        ),

      ),


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


