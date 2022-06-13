import 'dart:developer';

import 'package:meta/meta.dart';

class ComputeWinRate {
  int win;
  int lose;


  ComputeWinRate({@required int lose, @required int win}){
    this.lose = lose ?? 0;
    this.win = win ?? 0;
  }

  String computeWinrate(){
    var totalGames = this.win + this.lose;
    var rate = (win / totalGames) * 100;
    
    return (rate > 0 ? rate.toStringAsFixed(2) : "0") + "%";
  }
}