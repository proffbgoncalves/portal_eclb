import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class AbstractPortalAdministrationPage extends StatelessWidget {

  ExpansionTileController _cadastrosController = new ExpansionTileController();
  ExpansionTileController _movimentacoesController = new ExpansionTileController();

  AbstractPortalAdministrationPage({super.key});

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
                  width: 280,
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

                        new ListTile(
                          title: new Text(
                            "Início",
                            style: TextStyle(
                              fontSize: 14
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/admin");
                          },
                          leading: new Icon(Icons.home),
                          hoverColor: Color.fromRGBO(8, 58, 0, 100),
                        ),
                        new Divider(
                          color: Color.fromRGBO(8, 58, 0, 100), // Cor da linha
                          thickness: 1, // Espessura da linha
                        ),
                        new ExpansionTile(
                          title: new Text(
                            "Cadastros",
                            style: TextStyle(
                                fontSize: 14
                            ),
                          ),
                          controller: _cadastrosController,
                          leading: new Icon(Icons.table_view),
                          onExpansionChanged: (value) {
                            if (_movimentacoesController.isExpanded) {
                              _movimentacoesController.collapse();
                            }
                          },
                          children: [
                            new ListTile(
                              title: new Text(
                                "Tipos de Atuações",
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(context, "/admin/type_of_patrimony");
                              },
                              leading: new Icon(
                                  Icons.color_lens,
                                  size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Tipos de Eventos",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(
                                  Icons.event,
                                  size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Tipos de Históricos de Patrimônios",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(Icons.history_edu, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Tipos de Mídias",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(Icons.video_library, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Tipos de Patrimônios",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(Icons.nature, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Tipos de Patrimônios Simples",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(FontAwesomeIcons.book, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Tipos de Patrimônios Simples",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(FontAwesomeIcons.building, size: 16,
                              ),

                            ),
                          ],
                        ),
                        new Divider(
                          color: Color.fromRGBO(8, 58, 0, 100), // Cor da linha
                          thickness: 1, // Espessura da linha
                        ),
                        new ExpansionTile(
                            title: new Text(
                              "Movimentações",
                              style: TextStyle(
                                  fontSize: 14
                              ),
                            ),
                          controller: _movimentacoesController,
                          leading: new Icon(Icons.move_to_inbox),
                          onExpansionChanged: (value) {
                            if (_cadastrosController.isExpanded) {
                              _cadastrosController.collapse();
                            }
                          },
                          children: [
                            new ListTile(
                              title: new Text(
                                "Acervo",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(FontAwesomeIcons.boxArchive, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Ambientes",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(FontAwesomeIcons.doorOpen, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Eventos",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(Icons.event_available, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Históricos",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(Icons.history_edu_sharp, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Itinerários de Visitações",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(Icons.map, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Memórias",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(Icons.remember_me, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Pessoas Notáveis",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(FontAwesomeIcons.userAstronaut, size: 16,
                              ),

                            ),
                            new ListTile(
                              title: new Text(
                                "Quizes",
                              ),
                              onTap: () {

                              },
                              leading: new Icon(FontAwesomeIcons.question, size: 16,
                              ),

                            ),
                          ],
                        ),
                        new Divider(
                          color: Color.fromRGBO(8, 58, 0, 100), // Cor da linha
                          thickness: 1, // Espessura da linha
                        ),
                        new ListTile(
                          title: new Text(
                            "Usuários",
                            style: TextStyle(
                                fontSize: 14
                            ),
                          ),
                          onTap: () {

                          },
                          leading: new Icon(Icons.people),
                          hoverColor: Color.fromRGBO(8, 58, 0, 100),
                        ),
                        new Divider(
                          color: Color.fromRGBO(8, 58, 0, 100), // Cor da linha
                          thickness: 1, // Espessura da linha
                        ),
                        new ListTile(
                          title: new Text(
                            "Sair",
                            style: TextStyle(
                                fontSize: 14
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/");
                          },
                          leading: new Icon(Icons.logout),
                          hoverColor: Color.fromRGBO(8, 58, 0, 100),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.topCenter,
                  ),
                ),
                new SizedBox(
                  width: 1088,
                  child: new Container(
                    alignment: Alignment.topLeft,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Color.fromRGBO(222, 250, 217, 100) )
                    ),
                    margin: EdgeInsets.only(top: 8, right: 8, bottom: 8),
                    child: this.createChild(context),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createChild(BuildContext context);

  
}
