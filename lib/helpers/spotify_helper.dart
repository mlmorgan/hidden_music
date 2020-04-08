import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_helper.dart' as auth;
import '../models/access_token.dart';
import '../models/artist.dart';

class SpotifyHelper {
  static Future<Artist> getArtist(String genre) async {
    final random = new Random();
    final offset = random.nextInt(100);
    final accessToken = await _getAccessToken();
    final url =
        'https://api.spotify.com/v1/search?q=genre%3A$genre%20tag%3Ahipster&type=artist&limit=1&offset=$offset';

    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $accessToken'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final artist = json.decode(response.body)['artists']['items'][0];
    return Artist(
      name: artist['name'],
      imageURL: artist['images'][0]['url'],
      spotifyURL: artist['external_urls']['spotify'],
    );
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
