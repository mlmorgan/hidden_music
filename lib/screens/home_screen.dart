import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/spotify_helper.dart';
import '../widgets/genre_selector.dart';
import '../providers/genres.dart';
import '../widgets/artist_view.dart';
import '../models/artist.dart';
import '../widgets/artists_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() {}

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _artists;
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
      //backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          GenreSelector(getArtistsFnc: _getArtists),
          // Consumer<Genres>(
          //   builder: (ctx, genres, _) => RaisedButton(
          //     onPressed: () {
          //       _getArtist(genres.currentGenre);
          //     },
          //     color: Theme.of(context).primaryColor,
          //     child: Row(
          //       children: <Widget>[
          //         Text('Discover Hidden Artists'),
          //         Icon(Icons.library_music)
          //       ],
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     ),
          //     textColor: Colors.white,
          //     padding: const EdgeInsets.all(16),
          //   ),
          // ),
          Expanded(
            child: ArtistsList(_artists),
          ),
        ],
      ),
    );
  }
}
