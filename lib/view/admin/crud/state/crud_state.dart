import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class CRUDState extends State {

  Future<List>? _data;
  int _count = 0;
  int _limit, _offset = 1, _searchOption = 0, _numberOfPages = 0, _currentPage = 1;

  CRUDState(this._limit);

  void initState() {
    this._data = this.load(context, this._limit, 1);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: this._data,
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
                        this.insert(context);
                      },
                    ),
                    new SizedBox(
                      width: 270,
                    ),
                    new SizedBox(
                      width: 200,
                      height: 36,
                      child: new DropdownButtonFormField(
                        value: this._searchOption,
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
                        items: this.createSearchOptions(context),
                        onChanged: (value) {
                          setState(() {
                            this._searchOption = value!;
                          });
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
                          this._currentPage = 1;
                          this._data = this.load(context, this._limit, 1);
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
                            columns: this.createDataColumns(context),

                            rows: this.createDataRows(context, snapshot),

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
                                onPressed: this._currentPage == 1 ? null : (){
                                  setState(() {
                                    this._currentPage = 1;
                                    this._data = this.load(context, this._limit, this._offset);
                                  });
                                },
                              ),
                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.backward),
                                iconSize: 12,
                                tooltip: "Página anterior",
                                onPressed: this._currentPage == 1 ? null : () {
                                  setState(() {
                                    this._currentPage -= 1;
                                  });
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
                                      child: new FutureBuilder(
                                        future: this.count(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null) {
                                            return new Text(
                                              "1/1",
                                              style: new TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            );
                                          } else {
                                            this._count = snapshot.data!;
                                            if (this._count ~/ this._limit == 0 && this._count ~/ this._limit == 1) {
                                              this._numberOfPages = 1;
                                            } else if (this._count % this._limit == 0) {
                                              this._numberOfPages = (this._count / this._limit) as int;
                                            } else {
                                              this._numberOfPages = (this._count ~/ this._limit) + 1;
                                            }
                                            return new Text(
                                              this._currentPage.toString()+"/"+this._numberOfPages.toString(),
                                              style: new TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            );
                                          }


                                        },
                                      )

                                    )
                                ),
                              ),
                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.forward),
                                iconSize: 12,
                                tooltip: "Próxima página",
                                onPressed: this._currentPage == this._numberOfPages ? null : () {
                                  setState(() {
                                    this._currentPage += 1;
                                  });
                                },
                              ),

                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.forwardFast),
                                iconSize: 12,
                                tooltip: "Última página",
                                onPressed: this._currentPage == this._numberOfPages ? null : () {
                                  setState(() {
                                    this._currentPage = this._numberOfPages;
                                  });
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

  Future<bool> insert(BuildContext context);

  Future<List>? load(BuildContext context, int limit, int offset);

  Future<bool> delete(BuildContext context, Object id);

  Future<bool> update(BuildContext context, Object id);

  Future<List>? search(BuildContext context, int searchOption, String searchKey);

  Future<int> count(BuildContext context);

  List<DropdownMenuItem> createSearchOptions(BuildContext context);

  List<DataRow> createDataRows(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot);

  List<DataColumn> createDataColumns(BuildContext context);

}