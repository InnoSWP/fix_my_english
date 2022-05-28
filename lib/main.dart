import 'package:flutter/material.dart';
import 'pages.dart';

void main() {
  runApp(const MyApp());
}

//Root widget that will display other widgets
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fix my English',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainApp(title: 'Fix my English'),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainApp> createState() => _MainAppState();
}

//The main switching widget. Will display appropriate widget depending on state of application.
class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: StartPageWidget());
  }
}
