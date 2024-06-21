import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/base_page.dart';
import 'package:portal_eclb/view/admin/crud/typeofpatrimony/types_of_patrimonies_form.dart';

class TypesOfPatrimoniesPage extends BasePage {

  TypesOfPatrimoniesPage({super.key});

  @override
  Widget createChild(BuildContext context) {
    return new Container(
      alignment: Alignment.topLeft,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Breadcrumbs(
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Theme.of(context).colorScheme.primary
            ),
            crumbs: [
              new TextSpan(text: "Início"),
              new TextSpan(text: "Configurações"),
              new TextSpan(text: "Cadastros Básicos"),
              new TextSpan(text: "Tipos de Patrimônios"),
            ],
          ),
          new SizedBox(
            height: 24,
          ),
          new Row(
            children: [
              new Text(
                "Tipos de Patrimônios",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          new Divider(
            thickness: 1,
          ),
          new TypesOfPatrimoniesForm()
        ],
      ),
    );
  }

}