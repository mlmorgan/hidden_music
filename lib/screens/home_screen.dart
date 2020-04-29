import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../helpers/spotify_helper.dart';
import '../widgets/genre_selector.dart';
import '../widgets/artists_list.dart';
import '../models/artist.dart';
import '../widgets/info_dialog.dart';
import '../widgets/no_artists_info.dart';
import 'package:loading_overlay/loading_overlay.dart';

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

  void _getArtists(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final artists = await SpotifyHelper.getArtists(
          _genre.toLowerCase().replaceAll(' ', '-'), _showPopular);
      setState(() {
        _artists = artists;
      });
      _controller.move(0);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to fetch artists'),
          action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
              }),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _setGenre(String newGenre, BuildContext context) {
    setState(() {
      _genre = newGenre;
    });
    _getArtists(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Hidden Music'),
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.info),
      //         onPressed: () {
      //           showAboutDialog(
      //             context: context,
      //             applicationName: 'Hidden Music',
      //             applicationVersion: '0.1',
      //             children: <Widget>[InfoDialog()],
      //           );
      //         })
      //   ],
      // ),
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GenreSelector(setGenreFunc: _setGenre),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: (_artists.length == 0)
                          ? NoArtistsInfo()
                          : ArtistsList(_artists, _controller),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        (_genre != null)
                            ? Expanded(
                                child: Builder(builder: (BuildContext context) {
                                  return SwitchListTile.adaptive(
                                      value: _showPopular,
                                      title:
                                          Text('Show popular artists instead'),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _showPopular = newValue;
                                        });
                                        _getArtists(context);
                                      });
                                }),
                              )
                            : SizedBox(),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
