import 'package:flutter/material.dart';

import 'demo_util/demo3_body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Sound'),
        ),
        body: MainBody(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
