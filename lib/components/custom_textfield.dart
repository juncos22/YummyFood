import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/providers/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.errorText,
      required this.inputType,
      required this.isMultiline,
      required this.labelText,
      this.validatorFunction})
      : super(key: key);

  final TextEditingController controller;
  final String? errorText;
  final TextInputType inputType;
  final String labelText;
  final bool isMultiline;
  final void Function(String)? validatorFunction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      keyboardType: this.inputType,
      maxLines: this.isMultiline ? 3 : 1,
      onChanged: this.validatorFunction,
      decoration: InputDecoration(
        labelText: this.labelText,
        labelStyle: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDark
                ? kPrimaryColor
                : kTextColor),
        border: InputBorder.none,
        errorText: this.errorText,
      ),
    );
  }
}
