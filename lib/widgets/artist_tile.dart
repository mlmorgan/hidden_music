import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistTile extends StatelessWidget {
  final name;
  final imageURL;
  final spotifyURL;

  void _launchSpotify() async {
    if (await canLaunch(spotifyURL)) {
      await launch(spotifyURL);
    } else {
      throw 'Could not launch $spotifyURL';
    }
  }

  ArtistTile({
    @required this.name,
    @required this.imageURL,
    @required this.spotifyURL,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchSpotify,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: <Widget>[
              Image.network(
                imageURL,
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
