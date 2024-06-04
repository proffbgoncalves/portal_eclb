import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/abstract_portal_administration_page.dart';

final class TypeOfPatrimonyAdministrationPage extends AbstractPortalAdministrationPage {

  TypeOfPatrimonyAdministrationPage({super.key});

  @override
  Widget createChild(context) {
    return new Container(
      margin: EdgeInsets.all(30),
      alignment: Alignment.topLeft,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Breadcrumbs(
            separator: " > ",
            crumbs: [
              new TextSpan(text: "Home",),
              new TextSpan(text: "Tipos de Patrimônios"),
            ]
          ),
          new SizedBox(
            height: 16,
          ),
          new Text(
            "Tipos de Patrimônios",
            style: new TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 58, 0, 100)
            ),
          ),
          new Divider(
            color: Color.fromRGBO(8, 58, 0, 100),
            thickness: 1,
          )
        ],
      ),
    );
  }

}