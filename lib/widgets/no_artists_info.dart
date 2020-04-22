import 'package:flutter/material.dart';

class NoArtistsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.arrow_upward,
          color: Theme.of(context).accentColor,
          size: 100,
        ),
        Text(
          "No artists found.\nTry searching for a new genre.",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
