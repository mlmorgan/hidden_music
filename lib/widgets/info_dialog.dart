import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDialog extends StatelessWidget {
  void _openSpotify() async {
    final url = 'https://www.spotify.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'All artist data, imagery, and artwork, provided by the Spotify Web API\n\nBase app icon made by Freepik from www.flaticon.com',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: _openSpotify,
          child: Image.asset(
            'assets/images/Spotify_Logo_RGB_Green.png',
            height: 30,
          ),
        ),
      ],
    );
  }
}
