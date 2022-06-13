import 'package:flutter/material.dart';

class AppCrolor {
  var primary = Color(0xff8abfff);
  var primaryLight = Color(0xffbef1ff);
  var primaryDark = Color(0xff568fcc);

  var secondary = Color(0xff6897cc);
  var secondaryLight = Color(0xff9ac8ff);
  var secondaryDark = Color(0xff35699b);

  var grey = Color(0xff9aa6b3);
  var green = Color(0xff4dc95f);
  var red = Color(0xffc94f4d);

  color(v) {
    return Color(int.parse("0xff" + v));
  }
}
