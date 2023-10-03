import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color textColor;
  const RoundedButton(
    this.text, {
    required this.press,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      width: size.width * 0.8,
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
            ),
          )),
    );
  }
}
