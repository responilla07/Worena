
import 'package:flutter/cupertino.dart';

class Size {
  BuildContext context;

  Size(BuildContext context){
    this.context = context;
  }

  height(){
    return MediaQuery.of(context).size.height;
  }
  width(){
    return MediaQuery.of(context).size.width;
  }
}