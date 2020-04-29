import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_helper.dart' as auth;
import '../models/access_token.dart';
import '../models/artist.dart';

class SpotifyHelper {
  static Future<List<Artist>> getArtists(String genre, bool showPopular) async {
    final random = new Random();
    final limit = 50;
    final tag = showPopular ? '' : '%20tag%3Ahipster';
    final offset = 0; //random.nextInt(50);
    final accessToken = await _getAccessToken();
    final url =
        'https://api.spotify.com/v1/search?q=genre%3A${genre + tag}&type=artist&limit=$limit&offset=$offset';

    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode != 200) {
      throw ('Error fetching artists');
    }

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List artists = json.decode(response.body)['artists']['items'];

    return artists.map((artist) {
      String image;
      List<dynamic> images = artist['images'];

      if (images.length > 0) {
        image = artist['images'][0]['url'];
      } else {
        image = null;
      }

      return Artist(
        name: artist['name'],
        followers: artist['followers']['total'],
        imageURL: image,
        spotifyURL: artist['external_urls']['spotify'],
      );
    }).toList();
  }

  static Future<String> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    var tokenValue = prefs.getString('access_token_value');
    final tokenExpiry = prefs.getInt('access_token_expiry') ?? 0;

    if (tokenExpiry <= DateTime.now().millisecondsSinceEpoch) {
      var newAccessToken = await _fetchNewAccessToken();
      tokenValue = newAccessToken.value;

      prefs.setString('access_token_value', newAccessToken.value);
      prefs.setInt('access_token_expiry',
          newAccessToken.expiresAt.millisecondsSinceEpoch);
    }

    return tokenValue;
  }

  static Future<AccessToken> _fetchNewAccessToken() async {
    var url = 'https://accounts.spotify.com/api/token';

    var authString = '${auth.SPOTIFY_CLIENT_ID}:${auth.SPOTIFY_CLIENT_SECRET}';
    var authBytes = utf8.encode(authString);
    var authBase64 = base64.encode(authBytes);

    var response = await http.post(
      url,
      headers: {'Authorization': 'Basic ' + authBase64},
      body: {'grant_type': 'client_credentials'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var responseBody = json.decode(response.body);
    var accessToken = AccessToken(
      value: responseBody['access_token'],
      expiresAt: DateTime.now().add(
        Duration(
          seconds: responseBody['expires_in'],
        ),
      ),
    );

    return accessToken;
  }
}
