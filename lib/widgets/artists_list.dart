import 'package:flutter/material.dart';

import 'artist_tile.dart';
import '../models/artist.dart';

class ArtistsList extends StatelessWidget {
  final List<Artist> artists;

  ArtistsList(this.artists);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (BuildContext context, int index) {
        return ArtistTile(
          name: artists[index].name,
          imageURL: artists[index].imageURL,
          spotifyURL: artists[index].spotifyURL,
        );
      },
    );
  }
}
