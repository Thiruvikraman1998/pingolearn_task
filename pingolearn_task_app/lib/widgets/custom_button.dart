import 'package:flutter/material.dart';
import 'package:pingolearn_task_app/utils/theme_data.dart';

class CustomButton extends StatelessWidget {
  final void Function() onButtonPressed;
  final Widget buttonBodyWidget;

  const CustomButton(
      {super.key,
      required this.onButtonPressed,
      required this.buttonBodyWidget});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onButtonPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        maximumSize: WidgetStateProperty.all(
          Size(size.width * 0.6, size.height * 0.06),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(size.width * 0.6, size.height * 0.06),
        ),
        backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
        textStyle: WidgetStateProperty.all(
          TextStyle(color: AppTheme.secondaryColor),
        ),
      ),
      child: buttonBodyWidget,
    );
  }
}
