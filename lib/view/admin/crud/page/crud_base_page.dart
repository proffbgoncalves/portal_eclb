import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/base_page.dart';

abstract class CRUDBasePage extends BasePage {

  String _pageTitle;
  List<String> _breadCrumbs;

  CRUDBasePage(this._pageTitle, this._breadCrumbs, {super.key});

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
            crumbs: this._breadCrumbs.map((e) {
              return new TextSpan(text: e);
            }).toList(),
            // [
            //   new TextSpan(text: "Início"),
            //   new TextSpan(text: "Configurações"),
            //   new TextSpan(text: "Cadastros Básicos"),
            //   new TextSpan(text: "Tipos de Patrimônios"),
            // ],
          ),
          new SizedBox(
            height: 24,
          ),
          new Row(
            children: [
              new Text(
                this._pageTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          new Divider(
            thickness: 1,
          ),
          this.createStatefulWidget()
        ],
      ),
    );
  }

  StatefulWidget createStatefulWidget();

}