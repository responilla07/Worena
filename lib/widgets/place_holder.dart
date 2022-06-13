import 'package:flutter/material.dart';

class LoadPlayerFailed extends StatelessWidget {
  const LoadPlayerFailed({
    @required this.imageLocation,
  });
  final String imageLocation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Failed to load player",
      ),
    );
  }
}

class NoPlayersAvailable extends StatelessWidget {
  const NoPlayersAvailable({
    @required this.imageLocation,
  });
  final String imageLocation;

  @override
  Widget build(BuildContext context) {
    return Text(
      "No players available",
    );
  }
}
