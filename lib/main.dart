import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'providers/genres.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Genres(),
        ),
      ],
      child: MaterialApp(
        title: 'Hidden Music',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
