import 'package:atlascan_flutter/models/user.dart';
import 'package:flutter/material.dart';

class ScanRedirect extends StatelessWidget {
  const ScanRedirect({super.key});
  

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    User? user;
    

    if (ModalRoute.of(context)?.settings.arguments != null) {
      user = ModalRoute.of(context)?.settings.arguments as User;
    } else {
      Navigator.pushNamed(
        context,
        '/login',
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Blue Circles (Decorations)
          Positioned(
            left: screenWidth * 0.7,
            top: screenHeight * 0.55,
            child: Opacity(
              opacity: 0.25,
              child: Container(
                width: screenWidth * 1.1, // Relative to screen width
                height: screenWidth * 1.1, // Maintain aspect ratio
                decoration: const ShapeDecoration(
                  color: Color(0xFF2F4FCD),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            left: -screenWidth * 0.85,
            top: screenHeight * 0.02,
            child: Opacity(
              opacity: 0.25,
              child: Container(
                width: screenWidth * 1.1,
                height: screenWidth * 1.1,
                decoration: const ShapeDecoration(
                  color: Color(0xFF2F4FCD),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),

          // Main Column Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Image.asset(
                  'lib/images/scanimage.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Text Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scan Everywhere',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.06, // Responsive font size
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Scan documents everywhere, anytime, from your pocket.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.15),

              // Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.01,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F4FCD),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Container(
                    width: screenWidth * 0.02,
                    height: screenHeight * 0.01,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA7A7A7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Container(
                    width: screenWidth * 0.02,
                    height: screenHeight * 0.01,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA7A7A7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),

              // Next Button
              GestureDetector(
                onTap: () {
                  // Action for "NEXT" button
                  Navigator.pushNamed(
                  context, '/scan',
                  arguments: user,
                );
                },
                child: Container(
                  width: screenWidth * 0.85,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2F4FCD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
