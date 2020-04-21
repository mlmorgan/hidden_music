import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'providers/genres.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Genres(),
        ),
      ],
      child: MaterialApp(
        title: 'Hidden Music',
        theme: ThemeData(
          brightness: Brightness.dark,
          //primarySwatch: Colors.purple,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
