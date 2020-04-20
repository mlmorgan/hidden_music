import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../providers/genres.dart';

class GenreSelector extends StatelessWidget {
  final getArtistsFnc;

  GenreSelector({this.getArtistsFnc});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Genres>(
          builder: (ctx, genres, _) => SearchableDropdown.single(
            items: genres.genres.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.replaceRange(
                    0, 1, value.substring(0, 1).toUpperCase())),
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
          ),
        ),
      ),
    );
  }
}
