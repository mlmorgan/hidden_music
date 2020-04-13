import 'package:flutter/material.dart';

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
  void _getArtists(String genre) async {
    final artists = await SpotifyHelper.getArtists(
        genre.toLowerCase().replaceAll(' ', '-'));
    setState(() {
      _artists = artists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hidden Music'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          GenreSelector(getArtistsFnc: _getArtists),
          (_artists.length > 0)
              ? Expanded(
                  child: ArtistsList(_artists),
                )
              : Text("No artists found")
        ],
      ),
    );
  }
}
