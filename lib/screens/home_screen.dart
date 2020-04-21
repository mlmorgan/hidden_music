import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../helpers/spotify_helper.dart';
import '../widgets/genre_selector.dart';
import '../widgets/artists_list.dart';
import '../models/artist.dart';
import '../widgets/info_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() {}

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Artist> _artists = [];
  var _showPopular = false;
  var _genre;
  final controller = SwiperController();
  void _getArtists() async {
    final artists = await SpotifyHelper.getArtists(
        _genre.toLowerCase().replaceAll(' ', '-'), _showPopular);
    setState(() {
      _artists = artists;
    });
    controller.move(0);
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
      // appBar: AppBar(
      //   title: Text('Invisible Music'),
      //   actions: <Widget>[IconButton(icon: Icon(Icons.info), onPressed: () {})],
      // ),
      //backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GenreSelector(setGenreFunc: _setGenre),
            ),
            Expanded(
              child: (_artists.length > 0)
                  ? Column(
                      children: <Widget>[
                        Expanded(child: ArtistsList(_artists, controller)),
                        SwitchListTile.adaptive(
                            value: _showPopular,
                            title: Text('Show popular artists instead'),
                            onChanged: (newValue) {
                              setState(() {
                                _showPopular = newValue;
                              });
                              _getArtists();
                            }),
                      ],
                    )
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
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('Data and artwork supplied by'),
            //       SizedBox(width: 10),
            //       Image.asset(
            //         'assets/images/Spotify_Logo_RGB_White.png',
            //         height: 30,
            //       ),
            //     ],
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Invisible Music',
                      applicationVersion: '0.1',
                      children: <Widget>[InfoDialog()],
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
