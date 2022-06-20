import 'package:flutter/material.dart';

import '../../core/utils/validator.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: 'Password',
        suffix: GestureDetector(
          onTap: _toggleVisibility,
          child: isObscured
              ? const Icon(Icons.visibility_rounded)
              : const Icon(Icons.visibility_off_rounded),
        ),
      ),
      validator: (value) => Validator.validatePassword(value),
    );
  }

  void _toggleVisibility() {
    setState(() {
      isObscured = !isObscured;
    });
  }
}
