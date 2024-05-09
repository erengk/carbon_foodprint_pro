import 'package:flutter/material.dart';
import '../utils/customColors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.textColor = CustomColors.textButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.scaffoldBackgroundColor),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,

        ),),);
  }
}
