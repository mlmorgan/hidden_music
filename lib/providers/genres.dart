import 'package:flutter/foundation.dart';

class Genres with ChangeNotifier {
  static const _genres = <String>['Metal', 'Alternative', 'Electronic'];
  var _currentGenre = _genres[0];

  List<String> get genres {
    return _genres;
  }

  String get currentGenre {
    return _currentGenre;
  }

  void setCurrentGenre(newGenre) {
    _currentGenre = newGenre;
    notifyListeners();
  }
}
