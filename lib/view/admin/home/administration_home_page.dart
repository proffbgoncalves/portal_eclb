import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdministrationHomePage extends StatefulWidget {
  const AdministrationHomePage({super.key});

  @override
  State<AdministrationHomePage> createState() => _AdministrationHomePageState();

  void testando() {

  }
}

class _AdministrationHomePageState extends State<AdministrationHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(102),
        child: new Container(
          decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black.withOpacity(0.3), // Cor da sombra
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 1),
              )
            ]
          ),
          child: new AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: new SizedBox(
              height: 80,
              width: 193,
              child: Image.asset("assets/images/logo_eclb.png"),
            ),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(251, 249, 217, 100),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ),
      ),
      drawer: new Drawer(

        child: new ListView(
          children: [
            new DrawerHeader(
              child: new Text("Menu Principal"),
            ),
            new ExpansionTile(
              title: new Text("Teste 1"),
            )
          ],
        ),
      ),
    );
  }
}
