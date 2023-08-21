import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'display_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, String>> dataList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel App',
      home: InputScreen(dataList),
      routes: {
        '/display': (context) => DisplayScreen(dataList),
        '/input': (context) => InputScreen(dataList),
      },
    );
  }
}
