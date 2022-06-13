import 'package:flutter/material.dart';

class ContainerDecoration {
  var boxDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey[400],
        blurRadius: 2.0,
        spreadRadius: 0.0,
        offset: Offset(2.0, 2.0),
      )
    ],
    borderRadius: BorderRadius.all(
      Radius.circular(150),
    ),
  );
}
