import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hidden Music',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
      ),
      home: HomeScreen(),
    );
  }
}
