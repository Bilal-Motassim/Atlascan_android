import 'package:atlascan_flutter/models/document.dart';
import 'package:flutter/material.dart';
import 'document_box.dart';


class DocumentList extends StatefulWidget {
  final Function(Document) onDocumentSelected;

  const DocumentList({Key? key, required this.onDocumentSelected}) : super(key: key);

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
      selectedDocumentName = documents[index].name;
      print('Selected Document: $selectedDocumentName');

      // Trigger the callback to notify the parent
      widget.onDocumentSelected(documents[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return DocumentBox(
          name: documents[index].name,
          url: documents[index].url,
          isSelected: documents[index].isSelected,
          onSelected: (bool selected) {
            if (selected) {
              selectDocument(index);
            }
          },
        );
      },
    );
  }
}