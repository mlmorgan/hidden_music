import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/spotify_helper.dart';
import '../widgets/genre_selector.dart';
import '../providers/genres.dart';
import '../widgets/artist_view.dart';
import '../models/artist.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() {}

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var artistName = 'No artist';
  void _getArtist(String genre) async {
    final artist = await SpotifyHelper.getArtist(genre.toLowerCase());
    setState(() {
      artistName = artist.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hidden Music'),
      ),
      //backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            GenreSelector(),
            Consumer<Genres>(
              builder: (ctx, genres, _) => RaisedButton(
                onPressed: () {
                  _getArtist(genres.currentGenre);
                },
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: <Widget>[
                    Text('Discover Hidden Artists'),
                    Icon(Icons.library_music)
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            ArtistView(
              name: artistName,
            ),
          ],
        ),
      ),
    );
  }
}
