import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistView extends StatelessWidget {
  final name;
  final imageURL;
  final spotifyURL;

  void _launchSpotify(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ArtistView({this.name, this.imageURL, this.spotifyURL});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Image.network(
              imageURL,
              gaplessPlayback: true,
            ),
            onTap: () {
              _launchSpotify(spotifyURL);
            },
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 48,
            ),
          ),
        ],
      ),
    );
  }
}
