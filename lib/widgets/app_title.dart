import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String title;

  const AppTitle(
    this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.primary,
          fontWeight: FontWeight.w400,
          fontSize: 32,
        ));
  }
}
