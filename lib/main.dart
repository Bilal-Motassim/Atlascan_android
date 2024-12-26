import 'package:atlascan_flutter/screens/login_screen.dart';
import 'package:atlascan_flutter/screens/scan_choice.dart';
import 'package:atlascan_flutter/screens/scan_redirect.dart';
import 'package:atlascan_flutter/screens/splash_screen.dart';
import 'package:atlascan_flutter/screens/data_verif.dart';
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
      initialRoute: '/DataVerif',
      routes: {
        '/': (context) => SplashScreen(),
        '/scanredirect': (context) => ScanRedirect(),
        '/scan': (context) => ScanChoice(),
        '/LoginScreen': (context) => LoginScreen(),
        '/DataVerif': (context) => VerifDataScreen(),
      },
    );
  }
}
