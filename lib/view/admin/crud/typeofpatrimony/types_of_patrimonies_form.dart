import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:portal_eclb/view/admin/crud/state/crud_state.dart';

class TypesOfPatrimoniesForm extends StatefulWidget {

  const TypesOfPatrimoniesForm({super.key});

  @override
  _TypesOfPatrimoniesFormState createState() => _TypesOfPatrimoniesFormState(1);

}

class _TypesOfPatrimoniesFormState extends CRUDState {

  _TypesOfPatrimoniesFormState(super.limit);

  @override
  Future<int> count(BuildContext context) async {
    http.Response response = await http.get(Uri.parse("http://localhost:8080/api/admin/config/types_of_patrimonies/count"));

    throwIf(response.statusCode != 200, new Exception("Failed to load types od patrimonies"));
    
    var data = jsonDecode(response.body);

    return data["count"];
  }

  @override
  Future<bool> delete(BuildContext context, Object id) async {
    return false;
  }

  @override
  Future<bool> insert(BuildContext context) async {
    return false;
  }

  @override
  Future<List>? load(BuildContext context, int limit, int offset) async {
      http.Response response = await http.get(Uri.parse('http://localhost:8080/api/admin/config/types_of_patrimonies'));

      throwIf(response.statusCode != 200, new Exception("Failed to load types od patrimonies"));

      List<dynamic> data = jsonDecode(response.body);

      return data.toList();
  }

  @override
  Future<List>? search(BuildContext context, int searchOption, String searchKey) async {
    return [];
  }

  @override
  Future<bool> update(BuildContext context, Object id) async {
    return false;
  }

  @override
  List<DropdownMenuItem> createSearchOptions(BuildContext context) {
    return [
      new DropdownMenuItem(
        child: new Text(
          "Descrição",
          style: new TextStyle(
              fontSize: 13
          ),
        ),
        value: 0,),
    ];
  }

  @override
  List<DataColumn> createDataColumns(BuildContext context) {
    return [
      new DataColumn(label: new Container(
        width: 50, child: new Text("Código"),)),
      new DataColumn(label: new Container(
        width: 955, child: new Text("Descrição"),)),
      new DataColumn(label: new Container(
        alignment: Alignment.center,
        width: 80,
        child: new Text("Opções"),))
    ];
  }

  @override
  List<DataRow> createDataRows(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    return snapshot.data!.map((item) {
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
                            this.update(context, item["id"]);
                          }
                      ),
                      new IconButton(
                          tooltip: "Excluir",
                          icon: new Icon(
                              FontAwesomeIcons.trash),
                          iconSize: 12,
                          onPressed: () {
                            setState(() {
                              this.delete(context, item["id"]);

                            });
                          }
                      ),
                    ],
                  ),
                )
            )
          ]
      );
    },).toList();
  }
}
// showDialog(
//   context: context,
//   builder: (context) {
//     return new AlertDialog(
//       title: new Text("Confirmação"),
//       content: new Text("Deseja excluir este tipo de patrimônio?"),
//       actions: [
//         new ElevatedButton(
//           child: new Text("Confirmar"),
//           onPressed: () {
//             Navigator.of(context).pop(true); // Fecha o diálogo
//             this._deleteData(item["id"].toString());
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Registro excluído com sucesso.'),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//             Navigator.pushReplacementNamed(context, "/admin/config/types_of_patrimonies");
//           },
//
//         ),
//         new ElevatedButton(
//           child: new Text("Cancelar"),
//           style: ElevatedButton.styleFrom(
//               backgroundColor: Theme
//                   .of(context)
//                   .colorScheme
//                   .tertiary,
//               foregroundColor: Theme
//                   .of(context)
//                   .colorScheme
//                   .onTertiary
//           ),
//           onPressed: () {
//             Navigator.of(context).pop(false);
//           },
//         ),
//       ],
//     );
//   },
// );