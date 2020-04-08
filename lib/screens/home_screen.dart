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
  var imageUrl = '';
  var spotifyUrl = '';
  void _getArtist(String genre) async {
    final artist = await SpotifyHelper.getArtist(genre.toLowerCase());
    setState(() {
      artistName = artist.name;
      imageUrl = artist.imageURL;
      spotifyUrl = artist.spotifyURL;
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
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: ArtistView(
                name: artistName,
                imageURL: imageUrl,
                spotifyURL: spotifyUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
