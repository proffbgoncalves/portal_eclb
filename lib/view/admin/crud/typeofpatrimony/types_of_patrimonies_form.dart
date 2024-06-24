import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class TypesOfPatrimoniesForm extends StatefulWidget {

  const TypesOfPatrimoniesForm({super.key});

  @override
  State<TypesOfPatrimoniesForm> createState() => _TypesOfPatrimoniesFormState();

}

class _TypesOfPatrimoniesFormState extends State<TypesOfPatrimoniesForm> {

  Future<List>? _typeOfPatrimonies;

  void initState() {
    this._typeOfPatrimonies = this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: this._typeOfPatrimonies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Data Available'));
        } else {
         return  new Form(
            child: new Column(
              children: [
                new SizedBox(
                  height: 8,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new ElevatedButton.icon(
                      label: new Text("Inserir"),
                      icon: new Icon(Icons.add),
                      onPressed: () {

                      },
                    ),
                    new SizedBox(
                      width: 270,
                    ),
                    new SizedBox(
                      width: 200,
                      height: 36,
                      child: new DropdownButtonFormField(
                        value: 0,
                        iconEnabledColor: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        iconDisabledColor: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        decoration: new InputDecoration(
                          label: new Text("Buscar por"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        items: [
                          new DropdownMenuItem(
                            child: new Text(
                              "Descrição",
                              style: new TextStyle(
                                fontSize: 13
                              ),
                            ),
                            value: 0,),
                        ],
                        onChanged: (value) {

                        },
                      ),
                    ),
                    new SizedBox(
                      width: 16,
                    ),
                    new SizedBox(
                      width: 300,
                      height: 36,
                      child: new TextFormField(
                        style: TextStyle(fontSize: 13),
                        decoration: new InputDecoration(
                          label: new Text("Digite o valor"),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 8,
                    ),
                    new ElevatedButton.icon(
                      icon: new Icon(Icons.search),
                      label: new Text("Buscar"),
                      onPressed: () {

                      },
                    ),
                    new SizedBox(
                      width: 8,
                    ),
                    new ElevatedButton.icon(
                      icon: new Icon(Icons.list_alt),
                      label: new Text("Listar Todos"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme
                              .of(context)
                              .colorScheme
                              .tertiary,
                          foregroundColor: Theme
                              .of(context)
                              .colorScheme
                              .onTertiary
                      ),
                      onPressed: () {
                        setState(() {
                          this._typeOfPatrimonies = this._loadData();
                        });
                      },

                    ),
                  ],

                ),
                new SizedBox(
                  height: 8,
                ),
                new Container(
                  // width: 700,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(186, 192, 176, 100),
                    ),
                    padding: EdgeInsets.all(4),
                    child: new Column(
                      children: [
                        new DataTable(
                            columnSpacing: 24,
                            columns: [
                              new DataColumn(label: new Container(
                                width: 50, child: new Text("Código"),)),
                              new DataColumn(label: new Container(
                                width: 955, child: new Text("Descrição"),)),
                              new DataColumn(label: new Container(
                                alignment: Alignment.center,
                                width: 80,
                                child: new Text("Opções"),))
                            ],
                            rows: snapshot.data!.map((item) {
                              return new DataRow(
                                  cells: [
                                    new DataCell(new Container(
                                      width: 50, child: new Text(item["id"].toString()),)),
                                    new DataCell(new Container(width: 955,
                                      child: new Text(item["description"]),)),
                                    new DataCell(
                                        new Container(
                                          alignment: Alignment.center,
                                          width: 80,
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: [
                                              new IconButton(
                                                  tooltip: "Editar",
                                                  icon: new Icon(
                                                      FontAwesomeIcons.edit),
                                                  iconSize: 12,
                                                  onPressed: () {

                                                  }
                                              ),
                                              new IconButton(
                                                  tooltip: "Excluir",
                                                  icon: new Icon(
                                                      FontAwesomeIcons.trash),
                                                  iconSize: 12,
                                                  onPressed: () {
                                                    setState(() {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return new AlertDialog(
                                                            title: new Text("Confirmação"),
                                                            content: new Text("Deseja excluir este tipo de patrimônio?"),
                                                            actions: [
                                                              new ElevatedButton(
                                                                child: new Text("Confirmar"),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(true); // Fecha o diálogo
                                                                  this._deleteData(item["id"].toString());

                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      content: Text('Registro excluído com sucesso.'),
                                                                      behavior: SnackBarBehavior.floating,
                                                                    ),
                                                                  );
                                                                  Navigator.pushReplacementNamed(context, "/admin/config/types_of_patrimonies");
                                                                },

                                                              ),
                                                              new ElevatedButton(
                                                                child: new Text("Cancelar"),
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor: Theme
                                                                        .of(context)
                                                                        .colorScheme
                                                                        .tertiary,
                                                                    foregroundColor: Theme
                                                                        .of(context)
                                                                        .colorScheme
                                                                        .onTertiary
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(false);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    });
                                                  }
                                              ),
                                            ],
                                          ),
                                        )
                                    )
                                  ]
                              );
                            },).toList()
                        ),
                        new SizedBox(
                          height: 4,
                        ),
                        new Container(
                          height: 32,
                          child: new Row(

                            children: [
                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.backwardFast),
                                iconSize: 12,
                                tooltip: "Primeira página",
                                onPressed: () {

                                },
                              ),
                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.backward),
                                iconSize: 12,
                                tooltip: "Página anterior",
                                onPressed: () {

                                },
                              ),
                              new Container(
                                decoration: new BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: new SizedBox(
                                    width: 50,
                                    child: new Container(
                                      alignment: Alignment.center,
                                      child: new Text(
                                        "1/1",
                                        style: new TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                ),
                              ),
                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.forward),
                                iconSize: 12,
                                tooltip: "Próxima página",
                                onPressed: snapshot.data!.length < 10 ? null : () {

                                },
                              ),

                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.forwardFast),
                                iconSize: 12,
                                tooltip: "Última página",
                                onPressed: () {

                                },
                              )
                            ],
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          );
        }
      },
    );

  }

  Future<List> _loadData() async {
    http.Response response = await http.get(Uri.parse('http://localhost:8080/api/admin/config/types_of_patrimonies'));
    
    throwIf(response.statusCode != 200, new Exception("Failed to load types od patrimonies"));

    List<dynamic> data = jsonDecode(response.body);

    return data.toList();
  }

  Future<void> _deleteData(String id) async{
    try {
      String uri = 'http://localhost:8080/api/admin/config/type_of_patrimony/$id';

      print(uri);

      http.Response response = await http.delete(Uri.parse(uri));

      print(response.statusCode);
    } catch(erro) {
      print(erro);
      rethrow;
    }
  }

}
