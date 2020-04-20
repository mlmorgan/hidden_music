import 'package:flutter/material.dart';

import 'artist_tile.dart';
import '../models/artist.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ArtistsList extends StatelessWidget {
  final List<Artist> artists;
  final SwiperController controller;

  ArtistsList(this.artists, this.controller);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: artists.length,
      itemBuilder: (BuildContext context, int index) {
        return ArtistTile(
          artist: artists[index],
        );
      },
      loop: false,
      controller: controller,
      viewportFraction: 0.8,
      scale: 0.9,
      physics: BouncingScrollPhysics(),
    );
  }
}

// ListView.builder(
//       itemCount: artists.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ArtistTile(
//           name: artists[index].name,
//           imageURL: artists[index].imageURL,
//           spotifyURL: artists[index].spotifyURL,
//         );
//       },
//     );
