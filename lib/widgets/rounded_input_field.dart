import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String name;
  final String label;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const RoundedInputField(
    this.name,
    this.label, {
    super.key,
    this.icon,
    this.validator,
    this.obscureText = false,
    this.controller,
    required this.formData,
  });

  final Map<String, String> formData;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,

      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(29)
      ),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          formData[name] = value;
        },
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(icon, color: colors.primary),
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
