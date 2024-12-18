import 'package:atlascan_flutter/components/document_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ScanChoice extends StatefulWidget {
  const ScanChoice({super.key});
  @override
  _ScanChoiceState createState() => _ScanChoiceState();
}

class _ScanChoiceState extends State<ScanChoice> {
  bool showButtons = false;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Atlascan',
            style: TextStyle(
              color: Color(0xFF2F4FCD),
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            )
      ),
      actions: [
      IconButton(
        icon: Icon(Icons.account_circle),
        color: Color(0xFF2F4FCD), // User icon
        onPressed: () {
          // Handle icon press, e.g., navigate to profile page
          print('User icon pressed');
        },
      ),
    ],
      ),
      body: Stack(
        children: [
          Positioned(child: DocumentList()),






          Positioned(
            bottom: 110,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Buttons that are revealed
                  Visibility(
                    visible: showButtons, // Toggle visibility
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Scan from Camera Button
                        ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : () => _uploadImage(ImageSource.camera),
                          icon:
                              Icon(Icons.camera_alt, color: Color(0xFF2F4FCD)),
                          label: Text(
                            'Camera',
                            style: TextStyle(
                              color: Color(0xFF2F4FCD),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(160,
                                100), // Set a fixed width based on screen width
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                  color: Color(0xFF2F4FCD), width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12), // Space between buttons

                        // Select from Gallery Button
                        ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : () => _uploadImage(ImageSource.gallery),
                          icon: Icon(Icons.photo_library,
                              color: Color(0xFF2F4FCD)),
                          label: Text(
                            'Gallery',
                            style: TextStyle(
                              color: Color(0xFF2F4FCD),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(160,
                                100), // Set a fixed width based on screen width
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                  color: Color(0xFF2F4FCD), width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),








          Positioned(
              bottom: 0, // Pin to the bottom
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width, // Make it full width
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFDDDBFF)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left section with Logo and Line
                    Row(
                      children: [
                        // Flutter logo
                        Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Image.asset(
                          "lib/images/drawer.png",
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        ),
                        const SizedBox(width: 8),
                        // Decorative line
                        Container(
                          width: 12,
                          height: 2,
                          color: Color(0xFF2F4FCD),
                        ),
                      ],
                    ),
                    // Camera Button
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showButtons=!showButtons;
                        });
                      },
                      icon: Icon(Icons.lens_blur_outlined, color: Color(0xFF2F4FCD)),
                      label: Text(
                        'Scan',
                        style: TextStyle(
                          color: Color(0xFF2F4FCD),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: Color(0xFF2F4FCD),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Another Flutter logo (or another widget)
                    Container(
                      width: 24,
                      height: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Image.asset(
                          "lib/images/settings.png",
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2F4FCD)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _uploadImage(ImageSource source) async {
    if (_isLoading) return;

    try {
      setState(() => _isLoading = true);
      await Future.delayed(Duration(milliseconds: 500));

      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image == null) {
        setState(() => _isLoading = false);
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/api/classification/'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', image.path),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to process image. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
