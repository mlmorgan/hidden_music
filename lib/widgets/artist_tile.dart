import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistTile extends StatelessWidget {
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

  ArtistTile({this.name, this.imageURL, this.spotifyURL});
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Card(
      child: ListTile(
        onTap: () {
          _launchSpotify(spotifyURL);
        },
        leading: CircleAvatar(
          //radius: 40,
          backgroundImage: NetworkImage(imageURL),
        ),
        title: Text(
          name,
          style: TextStyle(
              //fontSize: 30,
              //fontWeight: FontWeight.bold,
              ),
        ),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
    // );
  }
}
