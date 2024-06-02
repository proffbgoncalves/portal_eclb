import 'package:flutter/material.dart';

class PortalAdministrationPage extends StatefulWidget {
  const PortalAdministrationPage({super.key});

  @override
  State<PortalAdministrationPage> createState() => _PortalAdministrationPageState();
}

class _PortalAdministrationPageState extends State<PortalAdministrationPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(251, 249, 217, 100),
      body: new Center(
        child: new SizedBox(
          width: 1400,
          child: new Container(
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0,2)
                  ),
                ],
                color: Color.fromRGBO(240, 246, 239, 100),
            ),
            alignment: Alignment.topLeft,
            child: new Row(
              children: <Widget>[
                new SizedBox(
                  width: 200,
                  child: new Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0))
                    ),
                    child: new Column(
                      children: [
                        Image.asset("assets/images/logo_eclb.png"),
                        new Divider(
                          color: Color.fromRGBO(8, 58, 0, 100), // Cor da linha
                          thickness: 1, // Espessura da linha
                        ),
                        new SizedBox(
                          height: 180,
                        ),
                        new SizedBox(
                          width: 200,
                          height: 40,
                          child: new TextButton(
                              style: TextButton.styleFrom(
                                  overlayColor: Color.fromRGBO(8, 58, 0, 100),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(8, 58, 0, 100),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                              ),

                              onPressed: () {

                              },
                              child: new Row(
                                children: [
                                  new Icon(
                                    Icons.home,
                                    color: Color.fromRGBO(8, 58, 0, 1),
                                  ),
                                  SizedBox(width: 8.0),
                                  new Text(
                                    "Início",
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color.fromRGBO(8, 58, 0, 1)
                                    ),
                                  )
                                ],
                              ),
                          ),
                        ),
                        new SizedBox(
                          width: 200,
                          height: 40,
                          child: new TextButton (
                              style: TextButton.styleFrom(
                                overlayColor: Color.fromRGBO(8, 58, 0, 100),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(8, 58, 0, 100),
                                  fontWeight: FontWeight.bold,
                                ),
                                  foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                              ),

                              onPressed: () {

                              },
                            child: new Row(
                              children: [
                                new Icon(
                                  Icons.category,
                                  color: Color.fromRGBO(8, 58, 0, 1),
                                ),
                                SizedBox(width: 8.0),
                                new Text(
                                  "Categorias",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color.fromRGBO(8, 58, 0, 1)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        new SizedBox(
                          width: 200,
                          height: 40,
                          child: new TextButton(
                              style: TextButton.styleFrom(
                                  overlayColor: Color.fromRGBO(8, 58, 0, 100),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(8, 58, 0, 100),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                              ),

                              onPressed: () {

                              },
                            child: new Row(
                              children: [
                                new Icon(
                                  Icons.people,
                                  color: Color.fromRGBO(8, 58, 0, 1),
                                ),
                                SizedBox(width: 8.0),
                                new Text(
                                  "Usuários",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color.fromRGBO(8, 58, 0, 1)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 40,
                        ),
                        new SizedBox(
                          width: 200,
                          height: 40,
                          child: new TextButton(
                              style: TextButton.styleFrom(

                                  shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(8, 58, 0, 100),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                              ),

                              onPressed: () {

                              },
                            child: new Row(
                              children: [
                                new Icon(
                                  Icons.logout,
                                  color: Color.fromRGBO(8, 58, 0, 1),
                                ),
                                SizedBox(width: 8.0),
                                new Text(
                                  "Sair",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color.fromRGBO(8, 58, 0, 1)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.topCenter,
                  ),
                ),
                new SizedBox(
                  width: 1167,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Color.fromRGBO(222, 250, 217, 100) )
                    ),
                    margin: EdgeInsets.only(top: 8, right: 8, bottom: 8),
                    child: new Container(
                      margin: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(16))
                                    ),
                                    textStyle: new TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(8, 58, 0, 100),
                                      fontWeight: FontWeight.bold
                                    ),
                                    foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.archive,
                                        size: 48.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      Text(
                                        'Acervo',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 56,
                              ),
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),

                                      foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.door_back_door,
                                        size: 48.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      Text(
                                        'Salas',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 1),
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 56,
                              ),
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),
                                      foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.history,
                                        size: 48.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      Text(
                                        'Histórico',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 1),
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 56,
                              ),
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),
                                      textStyle: new TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 100),
                                          fontWeight: FontWeight.bold
                                      ),
                                      foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 48.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      Text(
                                        'Mídia',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new SizedBox(
                            height: 56,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),
                                      textStyle: new TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 100),
                                          fontWeight: FontWeight.bold
                                      ),
                                      foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.event,
                                        size: 48.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      Text(
                                        'Eventos',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 56,
                              ),
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),
                                      textStyle: new TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 100),
                                          fontWeight: FontWeight.bold
                                      ),
                                      foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_2,
                                        size: 48.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      Text(
                                        'Pessoas Notáveis',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 56,
                              ),
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),
                                      textStyle: new TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 100),
                                          fontWeight: FontWeight.bold
                                      ),
                                      foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Icon(
                                        Icons.map,
                                        size: 64.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      new SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      new Text(
                                        'Itinerários de Visitação',
                                        style: TextStyle(
                                          fontSize: 12,

                                          color: Color.fromRGBO(8, 58, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 56,
                              ),
                              new SizedBox(
                                width: 120,
                                height: 120,
                                child: new TextButton(
                                  style: TextButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16))
                                      ),
                                      textStyle: new TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(8, 58, 0, 100),
                                          fontWeight: FontWeight.bold
                                      ),
                                      foregroundColor: Color.fromRGBO(8, 58, 0, 100)
                                  ),
                                  onPressed: () {

                                  },
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Icon(
                                        Icons.quiz,
                                        size: 64.0,
                                        color: Color.fromRGBO(8, 58, 0, 1),
                                      ),
                                      new SizedBox(height: 8.0), // Espaço entre o ícone e o texto
                                      new Text(
                                        'Quizes',
                                        style: TextStyle(
                                          fontSize: 12,

                                          color: Color.fromRGBO(8, 58, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
