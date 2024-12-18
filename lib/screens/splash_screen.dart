import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 844,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  // Top Gradient Decoration
                  Positioned(
                    left: 459.94,
                    top: 32,
                    child: Opacity(
                      opacity: 0.10,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(0.93),
                        child: Container(
                          width: 177.66,
                          height: 294.66,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFF2F4FCD), Color(0x002F4FCD)],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Bottom Gradient Decoration
                  Positioned(
                    left: 421.94,
                    top: 207,
                    child: Opacity(
                      opacity: 0.10,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(0.93),
                        child: Container(
                          width: 177.66,
                          height: 294.66,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFF2F4FCD), Color(0x002F4FCD)],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // App Title
                  Positioned(
                    left: 152,
                    top: 406,
                    child: Text(
                      'Atlascan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2F4FCD),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // App Version
                  Positioned(
                    left: 178,
                    top: 436,
                    child: Text(
                      'ver.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  // Logo Image
                  Positioned(
                    left: 144,
                    top: 297,
                    child: Container(
                      width: 103,
                      height: 99,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'), // Path to your logo
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
