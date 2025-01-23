import 'dart:convert';
import 'dart:developer';

import 'package:atlascan_flutter/components/document_list.dart';
import 'package:atlascan_flutter/models/document.dart';
import 'package:atlascan_flutter/models/user.dart';
import 'package:atlascan_flutter/screens/data_display.dart';
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
  User? user;
  Document? selectedDocument;

  final ImagePicker _picker = ImagePicker();

  void handleDocumentSelected(Document doc) {
    setState(() {
      selectedDocument = doc;
      showButtons = true; // Optionally show buttons when a document is selected
      print('Parent received selected document: ${selectedDocument?.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      user = ModalRoute.of(context)?.settings.arguments as User;
    } else {
      Navigator.pushNamed(
        context,
        '/login',
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atlascan',
            style: TextStyle(
              color: Color(0xFF2F4FCD),
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Color(0xFF2F4FCD), // User icon
            onPressed: () {
              // Handle icon press, e.g., navigate to profile page
              print(user?.token);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(child: DocumentList(
            onDocumentSelected: handleDocumentSelected,
          )),
          Positioned(
            bottom: 110,
            child: Padding(
              padding: EdgeInsets.all(16),
              child:
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
                          : () => _uploadImage(ImageSource.camera, context),
                      icon: Icon(Icons.camera_alt, color: Color(0xFF2F4FCD)),
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
                          side: BorderSide(color: Color(0xFF2F4FCD), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12), // Space between buttons

                    // Select from Gallery Button
                    ElevatedButton.icon(
                      onPressed: _isLoading
                          ? null
                          : () => _uploadImage(ImageSource.gallery, context),
                      icon: Icon(Icons.photo_library, color: Color(0xFF2F4FCD)),
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
                          side: BorderSide(color: Color(0xFF2F4FCD), width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(color: Color(0xFFDDDBFF)),
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
                        showButtons = !showButtons;
                      });
                    },
                    icon: Icon(Icons.lens_blur_outlined, color: Colors.white),
                    label: Text(
                      'Scan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2F4FCD),
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

  Future<void> _uploadImage(ImageSource source, BuildContext context) async {
    if (_isLoading) return;

    try {
      setState(() => _isLoading = true);
      await Future.delayed(Duration(milliseconds: 500));

      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 100,
      );

      var url;
      if(selectedDocument!=null){
        switch (selectedDocument?.name) {
          case "ID Card":
          url = 'http://65.20.105.247:8001/id-card/extract/';
            break;
          case "Driver Licence":
          url = 'http://65.20.105.247:8001/drivers-license/extract/';
            break;
          case "Passport":
          url = 'http://65.20.105.247:8001/passport/extract/';
          break;
          default:
        }
      }

      if (image == null) {
        setState(() => _isLoading = false);
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', image.path),
      );
      //request.headers['Authorization'] = 'Bearer ${user?.token}';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      String decodedBody = utf8.decode(response.bodyBytes);

      var extractedData = json.decode(decodedBody);
      print(extractedData);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DataDisplayScreen(data: extractedData),
        ),
      );

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
