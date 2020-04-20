import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/artist.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;

  void _launchSpotify() async {
    if (await canLaunch(artist.spotifyURL)) {
      await launch(artist.spotifyURL);
    } else {
      throw 'Could not launch ${artist.spotifyURL}';
    }
  }

  ArtistTile({@required this.artist});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 320,
                width: double.infinity,
                child: artist.imageURL == null
                    ? Icon(
                        Icons.account_circle,
                        size: 160,
                      )
                    : Image.network(
                        artist.imageURL,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          artist.name,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            artist.followers.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: _launchSpotify,
                        child: Text(
                          'OPEN IN SPOTIFY',
                          style: TextStyle(fontSize: 15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 64),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
