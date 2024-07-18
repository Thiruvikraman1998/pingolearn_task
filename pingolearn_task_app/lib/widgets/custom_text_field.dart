import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingolearn_task_app/utils/theme_data.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final void Function(String)? onTextFieldChanged;
  final IconButton? suffixIcon;
  final bool textObscure;
  final String? hintText;
  final String labelText;
  final FocusNode? focusNode;

  const CustomTextField(
      {super.key,
      required this.textController,
      required this.labelText,
      this.onTextFieldChanged,
      this.suffixIcon,
      this.hintText,
      this.textObscure = false,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: onTextFieldChanged,
      obscureText: textObscure,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          label: Text(labelText),
          fillColor: AppTheme.secondaryColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppTheme.secondaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppTheme.secondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppTheme.secondaryColor))),
    );
  }
}
