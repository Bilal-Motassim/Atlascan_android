import 'package:atlascan_flutter/models/document.dart';
import 'package:flutter/material.dart';
import 'document_box.dart';


class DocumentList extends StatefulWidget {
  const DocumentList({super.key});

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  List<Document> documents = [
    Document(name: 'ID Card', url: 'lib/images/idcard.png'),
    Document(name: 'Passport', url: 'lib/images/passport.png'),
    Document(name: 'Driver Licence', url: 'lib/images/driver.png'),
  ];

  String? selectedDocumentName;

  void selectDocument(int index) {
    setState(() {
      for (int i = 0; i < documents.length; i++) {
        documents[i].isSelected = (i == index);
      }
      selectedDocumentName = documents[index].name; // Save the selected document name
      print('Selected Document: $selectedDocumentName'); // Log for debugging
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return DocumentBox(
            name: documents[index].name,
            url: documents[index].url,
            isSelected: documents[index].isSelected,
            onSelected: (bool selected) {
              selectDocument(index);
            },
          );
        },
      ),
    );
  }
}
