import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/resource/session/mariadb_database_session_manager.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

abstract class BasePage extends StatelessWidget {
  BasePage({super.key});

  ScrollController _verticalScrollController = new ScrollController();
  ScrollController _horizontalScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder(
        future: this.loadConfiguration(),
        builder: (context, snapshot) {
          return new Scrollbar(
            controller: this._verticalScrollController,
            child: new SingleChildScrollView(
              controller: this._verticalScrollController,
              scrollDirection: Axis.vertical,
              child: new Scrollbar(
                controller: this._horizontalScrollController,
                child: new SingleChildScrollView(
                  controller: this._horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: new Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(20),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new SizedBox(
                          width: 280,
                          child: new Container(
                            alignment: Alignment.topLeft,
                            decoration: new BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            padding: EdgeInsets.all(16),
                            child: new Column(
                              children: [
                                Image.asset("assets/images/logo_eclb.png"),

                                new Divider(
                                  color: Theme.of(context).colorScheme.primary,
                                  thickness: 1,
                                ),

                                new ListTile(
                                  title: new Text("Início"),
                                  leading: new Icon(Icons.home),
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, "/admin");
                                  },
                                ),

                                new Divider(
                                  color: Theme.of(context).colorScheme.primary,
                                  thickness: 1,
                                ),

                                new ListTile(
                                  title: new Text("Ambientes"),
                                  leading: new Icon(Icons.door_sliding),
                                  onTap: () {

                                  },
                                ),


                                new ExpansionTile(
                                  title: new Text("Acervo"),
                                  children: [
                                    new ListTile(
                                      title: new Text("Coleções"),
                                      titleTextStyle: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      contentPadding: EdgeInsets.only(left: 50),
                                      // leading: new Icon(Icons.category_outlined),
                                      onTap: () {

                                      },
                                    ),
                                    new ListTile(
                                      title: new Text("Itens do Acervo"),
                                      titleTextStyle: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      contentPadding: EdgeInsets.only(left: 50),
                                      // leading: new Icon(Icons.category_outlined),
                                      onTap: () {

                                      },
                                    ),

                                  ],
                                  leading: new Icon(Icons.archive),
                                ),

                                new ListTile(
                                  title: new Text("Exposições Virtuais"),
                                  leading: new Icon(Icons.local_library),
                                  onTap: () {

                                  },
                                ),

                                new ListTile(
                                  title: new Text("Mídia"),
                                  leading: new Icon(Icons.perm_media),
                                  onTap: () {

                                  },
                                ),

                                new ListTile(
                                  title: new Text("Eventos"),
                                  leading: new Icon(Icons.event),
                                  onTap: () {

                                  },
                                ),

                                new ListTile(
                                  title: new Text("Histórico"),
                                  leading: new Icon(Icons.history_edu),
                                  onTap: () {

                                  },
                                ),

                                new ListTile(
                                  title: new Text("Notícias"),
                                  leading: new Icon(Icons.newspaper),
                                  onTap: () {

                                  },
                                ),

                                new ListTile(
                                  title: new Text("Itinerários de Visitação"),
                                  leading: new Icon(Icons.map),
                                  onTap: () {

                                  },
                                ),

                                new ExpansionTile(
                                  title: new Text("Visitações"),
                                  children: [
                                    new ListTile(
                                      title: new Text("Guias"),
                                      titleTextStyle: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      contentPadding: EdgeInsets.only(left: 50),
                                      // leading: new Icon(Icons.category_outlined),
                                      onTap: () {

                                      },
                                    ),
                                    new ListTile(
                                      title: new Text("Visitas Guiadas"),
                                      titleTextStyle: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      contentPadding: EdgeInsets.only(left: 50),
                                      // leading: new Icon(Icons.category_outlined),
                                      onTap: () {

                                      },
                                    ),
                                    new ListTile(
                                      title: new Text("Visitantes"),
                                      titleTextStyle: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      contentPadding: EdgeInsets.only(left: 50),
                                      // leading: new Icon(Icons.category_outlined),
                                      onTap: () {

                                      },
                                    ),

                                  ],
                                  leading: new Icon(Icons.archive),
                                ),
                                new Divider(
                                  color: Theme.of(context).colorScheme.primary,
                                  thickness: 1,
                                ),
                                new ExpansionTile(
                                  title: new Text("Relatórios"),
                                  leading: new Icon(Icons.print),
                                ),
                                new Divider(
                                  color: Theme.of(context).colorScheme.primary,
                                  thickness: 1,
                                ),
                                new ExpansionTile(
                                  title: new Text("Configurações"),
                                  leading: new Icon(Icons.settings),
                                  children: [
                                    new ListTile(
                                      title: new Text("Usuários"),
                                      titleTextStyle: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      contentPadding: EdgeInsets.only(left: 50),
                                      // leading: new Icon(Icons.category_outlined),
                                      onTap: () {

                                      },
                                    ),
                                    new ExpansionTile(
                                      title: new Text(
                                        "Cadastros Básicos",
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      children: [
                                        new ListTile(
                                          title: new Text("Tipos de Atuações"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },

                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Eventos"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },
                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Históricos"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },
                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Mídias"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },
                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Notícias"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },
                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Patrimônios"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {
                                            Navigator.pushReplacementNamed(context, "/admin/config/types_of_patrimonies");
                                          },
                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Patrimônios Compostos"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },
                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Patrimônios Simples"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },
                                        ),
                                        new ListTile(
                                          title: new Text("Tipos de Mídias"),
                                          titleTextStyle: new TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          contentPadding: EdgeInsets.only(left: 64),
                                          // leading: new Icon(Icons.category_outlined),
                                          onTap: () {

                                          },
                                        ),
                                      ],
                                      tilePadding: EdgeInsets.only(left: 50),
                                    )
                                  ],
                                ),
                                new Divider(
                                  color: Theme.of(context).colorScheme.primary,
                                  thickness: 1,
                                ),
                                new ListTile(
                                  title: new Text("Sair"),
                                  titleTextStyle: new TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                  leading: new Icon(Icons.exit_to_app),
                                  onTap: () {

                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 1220,
                          height: 735,
                          child: new Container(
                            margin: EdgeInsets.only(left: 16),
                            padding: EdgeInsets.all(24),
                            alignment: Alignment.topLeft,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white
                            ),
                            child: this.createChild(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )

    );
  }

  Widget createChild(BuildContext context);

  Future<void> loadConfiguration() async {
    EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env");

    DependencyInjector injector = DependencyInjector.getInstance();

    if (!injector.hasDatabaseSessionManager(configuration.get("dbms"))) {
      MariaDBDatabaseSessionManager manager = new MariaDBDatabaseSessionManager(configuration);
      injector.registerDatabaseSessionManager(configuration.get("dbms"), manager);
    }

    if (!injector.hasDAOFactory(configuration.get("dbms"))) {
      MariaDBDAOFactory factory = new MariaDBDAOFactory(configuration);
      injector.registerDAOFactory(configuration.get("dbms"), factory);
    }
  }
}
