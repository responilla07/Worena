import 'package:flutter/material.dart';
import 'package:word_game/styles/styles.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    @required this.text,
    @required this.function,
  });

  final text;
  final Function function;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final AppCrolor appColor = AppCrolor();
  final TextStyles style = TextStyles();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8.5,
        color: appColor.secondary,
        child: Container(
          height: 40,
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: style.primaryFontFamily,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
