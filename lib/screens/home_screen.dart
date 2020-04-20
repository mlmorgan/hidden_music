import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../helpers/spotify_helper.dart';
import '../widgets/genre_selector.dart';
import '../widgets/artists_list.dart';
import '../models/artist.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() {}

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Artist> _artists = [];
  final controller = SwiperController();
  void _getArtists(String genre) async {
    final artists = await SpotifyHelper.getArtists(
        genre.toLowerCase().replaceAll(' ', '-'));
    setState(() {
      _artists = artists;
      controller.move(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invisible Music'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GenreSelector(getArtistsFnc: _getArtists),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: (_artists.length > 0)
                  ? ArtistsList(_artists, controller)
                  : Column(
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
                    ),
            ),
          )
        ],
      ),
    );
  }
}
