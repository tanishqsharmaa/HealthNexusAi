import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? Function(String?)? validator;

  const InputField({
    Key? key,
    required this.label,
    this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validator: validator,
        ),
      ],
    );
  }
}
