import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 200,
      child: Column(
        children: <Widget>[

          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    child: Image.asset("assets/images/logo_eclb.png"),
                  )
                ],
              ),
              Column(
                children: <Widget>[

                ],
              ),
            ],
          )

        ],
      ),
    );
  }
}
