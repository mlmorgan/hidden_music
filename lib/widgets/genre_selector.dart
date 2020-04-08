import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/genres.dart';

class GenreSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Consumer<Genres>(
        builder: (ctx, genres, _) => DropdownButton(
          items: genres.genres.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value
                  .replaceAll('-', ' ')
                  .replaceRange(0, 1, value.substring(0, 1).toUpperCase())),
            );
          }).toList(),
          onChanged: (String newValue) {
            //setState(() {
            genres.setCurrentGenre(newValue);
            //});
          },
          isExpanded: true,
          value: genres.currentGenre,
          //underline: Container(),
        ),
      ),
    );
  }
}
