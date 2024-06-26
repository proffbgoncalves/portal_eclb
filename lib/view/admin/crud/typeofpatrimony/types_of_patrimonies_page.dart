import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_eclb/view/admin/crud/page/crud_base_page.dart';
import 'package:portal_eclb/view/admin/crud/typeofpatrimony/types_of_patrimonies_form.dart';

class TypesOfPatrimoniesPage extends CRUDBasePage {

  TypesOfPatrimoniesPage() : super("Tipos de Patrimônios", ["Início", "Configurações", "Cadastros Básicos", "Tipos de Patrimônios"]);

  @override
  StatefulWidget createStatefulWidget() {
    return new TypesOfPatrimoniesForm();
  }



}