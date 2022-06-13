import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:word_game/styles/styles.dart';

class PlayerPlaceHolderCard extends StatefulWidget {
  PlayerPlaceHolderCard();
  @override
  _PlayerPlaceHolderState createState() => _PlayerPlaceHolderState();
}

class _PlayerPlaceHolderState extends State<PlayerPlaceHolderCard> {
  final AppCrolor appColor = AppCrolor();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.black26,
      // elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: appColor.grey,
                  radius: 20,
                  child: ClipOval(
                    child: Container(
                      height: 140,
                      width: 140,
                      child: Shimmer(
                        duration: Duration(seconds: 1),
                        interval: Duration(
                            seconds: 1),
                        color: Colors.black,
                        direction: ShimmerDirection.fromLTRB(),
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                shimer(70.0 + Random().nextInt(70), Random().nextInt(4)),
                SizedBox(height: 8),
                shimer(40.0 + Random().nextInt(50), Random().nextInt(4)),
              ],
            ),
            shimer(60.0 + Random().nextInt(50), Random().nextInt(4)),
          ],
        ),
      ),
    );
  }

  shimer(width, interval){
    return Container(
      height: 18,
      width: width,
      child: Shimmer(
        // enabled: false,
        duration: Duration(seconds: 1),
        interval:
            Duration(seconds: interval + 1),
            // Duration(seconds: 1),
        color: Colors.black,
        direction: ShimmerDirection.fromLTRB(),
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
