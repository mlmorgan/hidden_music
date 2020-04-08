import 'package:flutter/material.dart';

import '../helpers/spotify_helper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() {
    SpotifyHelper.getArtist('alternative');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hidden Music'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
