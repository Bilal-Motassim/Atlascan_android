import 'package:atlascan_flutter/screens/login_screen.dart';
import 'package:atlascan_flutter/screens/scan_choice.dart';
import 'package:atlascan_flutter/screens/scan_redirect.dart';
import 'package:atlascan_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atlascan',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Initial route when the app starts
      routes: {
        '/': (context) => SplashScreen(),
        '/scanredirect':(context) => ScanRedirect(),
        '/scan':(context) => ScanChoice(),
        '/LoginScreen':(context) => LoginScreen() // Home screen route // Second screen route
      },
    );
  }
}
