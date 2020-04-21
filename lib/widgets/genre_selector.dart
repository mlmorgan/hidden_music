import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:strings/strings.dart' as Strings;

import '../providers/genres.dart';

class GenreSelector extends StatelessWidget {
  final getArtistsFnc;

  GenreSelector({this.getArtistsFnc});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            // Icon(
            //   Icons.library_music,
            //   color: Theme.of(context).accentColor,
            // ),
            // SizedBox(width: 20),
            Expanded(
              child: Consumer<Genres>(
                builder: (ctx, genres, _) => SearchableDropdown.single(
                  items: genres.genres
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(Strings.camelize(value)),
                      // child: Text( value.replaceRange(
                      //     0, 1, value.substring(0, 1).toUpperCase())),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    if (newValue != null) {
                      genres.setCurrentGenre(newValue);
                      getArtistsFnc(genres.currentGenre);
                    }
                  },
                  value: genres.currentGenre,
                  isExpanded: true,
                  displayClearIcon: false,
                  hint: 'Search Genres',
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 30.0,
                  iconEnabledColor: Theme.of(context).accentColor,
                  underline: SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
