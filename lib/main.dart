import 'package:atlascan_flutter/screens/scan_choice.dart';
import 'package:atlascan_flutter/screens/scan_redirect.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ScanRedirect(),
        '/scan':(context) => ScanChoice()
      },
    );
  }
}
