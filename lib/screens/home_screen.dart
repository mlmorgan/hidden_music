import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../helpers/spotify_helper.dart';
import '../widgets/genre_selector.dart';
import '../widgets/artists_list.dart';
import '../models/artist.dart';
import '../widgets/info_dialog.dart';
import '../widgets/no_artists_info.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() {}

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Artist> _artists = [];
  var _showPopular = false;
  var _genre;
  var _isLoading = false;
  final _controller = SwiperController();

  void _getArtists() async {
    setState(() {
      _isLoading = true;
    });
    final artists = await SpotifyHelper.getArtists(
        _genre.toLowerCase().replaceAll(' ', '-'), _showPopular);
    setState(() {
      _isLoading = false;
      _artists = artists;
    });
    _controller.move(0);
  }

  void _setGenre(String newGenre) {
    setState(() {
      _genre = newGenre;
    });
    _getArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Genres'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Hidden Music',
                  applicationVersion: '0.1',
                  children: <Widget>[InfoDialog()],
                );
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GenreSelector(setGenreFunc: _setGenre),
            ),
            Expanded(
              child: (_isLoading)
                  ? Center(child: CircularProgressIndicator())
                  : (_artists.length == 0)
                      ? NoArtistsInfo()
                      : ArtistsList(_artists, _controller),
            ),
            (_genre != null)
                ? SwitchListTile.adaptive(
                    value: _showPopular,
                    title: Text('Show popular artists instead'),
                    onChanged: (_isLoading)
                        ? null
                        : (newValue) {
                            setState(() {
                              _showPopular = newValue;
                            });
                            _getArtists();
                          })
                : SizedBox()
            // try adding switch after artistlist to see if bug still occurs to narrow down problem
          ],
        ),
      ),
    );
  }
}

// (_isLoading)
//                 ? Expanded(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   )
//                 : Expanded(
//                     child: Column(
//                       children: <Widget>[
//                         Expanded(
//                           child: (_artists.length == 0)
//                               ? Column(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.arrow_upward,
//                                       color: Theme.of(context).accentColor,
//                                       size: 100,
//                                     ),
//                                     Text(
//                                       "No artists found.\nTry searching for a new genre.",
//                                       style: TextStyle(fontSize: 20),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 )
//                               : ArtistsList(_artists, _controller),
//                         ),
//                         SwitchListTile.adaptive(
//                             value: _showPopular,
//                             title: Text('Show popular artists instead'),
//                             onChanged: (newValue) {
//                               setState(() {
//                                 _showPopular = newValue;
//                               });
//                               _getArtists();
//                             }),
//                       ],
//                     ),
//                   ),
