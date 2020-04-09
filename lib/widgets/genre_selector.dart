import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../providers/genres.dart';

class GenreSelector extends StatelessWidget {
  final getArtistsFnc;

  GenreSelector({this.getArtistsFnc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Consumer<Genres>(
          builder: (ctx, genres, _) => SearchableDropdown.single(
                items:
                    genres.genres.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.replaceRange(
                        0, 1, value.substring(0, 1).toUpperCase())),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  genres.setCurrentGenre(newValue);
                  getArtistsFnc(genres.currentGenre);
                },
                value: genres.currentGenre,
                isExpanded: true,
                displayClearIcon: false,
                hint: 'Search Genres',
              )),
    );
  }
}
