import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';

class BlueBorder extends StatelessWidget {
  const BlueBorder(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: context.theme.primaryColor),
      ),
      child: FittedBox(child: child),
    );
  }
}
