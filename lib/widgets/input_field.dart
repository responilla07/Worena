import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  // InputField({

  // });

  @override
  _InputFieldtate createState() => _InputFieldtate();
}

class _InputFieldtate extends State<InputField> {
  int len = 5;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        maxLines: 1,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          isDense: true,
          hintText: "Type a answer...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
