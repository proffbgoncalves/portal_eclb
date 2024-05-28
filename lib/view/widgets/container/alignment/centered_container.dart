import 'package:flutter/material.dart';

class CenteredContainer extends StatelessWidget {

  final Widget child;

  const CenteredContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 10),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1200),
        child: child,
      ),
    );
  }
}
