import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portal_eclb/view/admin/abstract_portal_administration_page.dart';

final class AdministrationHomePage extends AbstractPortalAdministrationPage {

  AdministrationHomePage({super.key});

  @override
  Widget createChild(context) {
    return new Container(
      margin: EdgeInsets.all(16),
    );
  }

}