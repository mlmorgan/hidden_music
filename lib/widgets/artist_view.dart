import 'package:flutter/material.dart';

class ArtistView extends StatelessWidget {
  final name;

  ArtistView({this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(name),
        ],
      ),
    );
  }
}
