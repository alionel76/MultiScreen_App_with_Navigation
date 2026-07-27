import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    this.validator,
    this.onSaved,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
      ),
    );
  }
}
