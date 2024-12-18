import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scanner Icon
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CustomPaint(
                    painter: ScannerIconPainter(),
                  ),
                ),
              ),
            ),

            // Text Content
            Text(
              'Scan Everywhere',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Scan documents everywhere\neverytime from your pocket.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            SizedBox(height: 80),

            // Bottom Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF2F4FCD),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF2F4FCD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class ScannerIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF2F4FCD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final width = size.width;
    final height = size.height;
    final cornerLength = size.width * 0.3;

    // Top left corner
    canvas.drawLine(
      Offset(0, cornerLength),
      Offset(0, 0),
      paint,
    );
    canvas.drawLine(
      Offset(0, 0),
      Offset(cornerLength, 0),
      paint,
    );

    // Top right corner
    canvas.drawLine(
      Offset(width - cornerLength, 0),
      Offset(width, 0),
      paint,
    );
    canvas.drawLine(
      Offset(width, 0),
      Offset(width, cornerLength),
      paint,
    );

    // Bottom left corner
    canvas.drawLine(
      Offset(0, height - cornerLength),
      Offset(0, height),
      paint,
    );
    canvas.drawLine(
      Offset(0, height),
      Offset(cornerLength, height),
      paint,
    );

    // Bottom right corner
    canvas.drawLine(
      Offset(width - cornerLength, height),
      Offset(width, height),
      paint,
    );
    canvas.drawLine(
      Offset(width, height - cornerLength),
      Offset(width, height),
      paint,
    );

    // Middle lines
    canvas.drawLine(
      Offset(width * 0.3, height * 0.5),
      Offset(width * 0.7, height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}