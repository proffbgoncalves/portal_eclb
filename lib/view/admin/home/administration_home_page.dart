import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portal_eclb/view/admin/base_page.dart';

class AdministrationHomePage extends BasePage {

  AdministrationHomePage({super.key});

  @override
  Widget createChild(BuildContext context) {
    // TODO: implement createChild
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

}