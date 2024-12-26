import 'package:flutter/material.dart';

class VerifDataScreen extends StatefulWidget {
  final Map<String, dynamic> extractedData;

  VerifDataScreen({required this.extractedData});

  @override
  _VerifDataScreenState createState() => _VerifDataScreenState();
}

class _VerifDataScreenState extends State<VerifDataScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController arabicNameController;
  late TextEditingController frenchNameController;
  late TextEditingController arabicBirthplaceController;
  late TextEditingController frenchBirthplaceController;
  late TextEditingController idNumberController;
  late TextEditingController birthDateController;
  late TextEditingController expiryDateController;

  @override
  void initState() {
    super.initState();
    var arabic = widget.extractedData['extracted_data']['arabic'];
    var french = widget.extractedData['extracted_data']['french'];

    arabicNameController = TextEditingController(text: arabic['nom_complet']);
    frenchNameController = TextEditingController(text: french['nom_complet']);
    arabicBirthplaceController = TextEditingController(text: arabic['lieu_naissance']);
    frenchBirthplaceController = TextEditingController(text: french['lieu_naissance']);
    idNumberController = TextEditingController(text: arabic['num_cni']);
    birthDateController = TextEditingController(text: arabic['date_naissance']);
    expiryDateController = TextEditingController(text: arabic['date_expiration']);
  }

  @override
  void dispose() {
    arabicNameController.dispose();
    frenchNameController.dispose();
    arabicBirthplaceController.dispose();
    frenchBirthplaceController.dispose();
    idNumberController.dispose();
    birthDateController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isArabic = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF1F41BB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF1F41BB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF1F41BB), width: 2),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create the JSON data structure
      final formData = {
        "extracted_data": {
          "arabic": {
            "nom_complet": arabicNameController.text,
            "lieu_naissance": arabicBirthplaceController.text,
            "date_naissance": birthDateController.text,
            "date_expiration": expiryDateController.text,
            "num_cni": idNumberController.text,
          },
          "french": {
            "nom_complet": frenchNameController.text,
            "lieu_naissance": frenchBirthplaceController.text,
            "date_naissance": birthDateController.text,
            "date_expiration": expiryDateController.text,
            "num_cni": idNumberController.text,
          }
        }
      };

      // TODO: Send the data to your API
      print(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text(
                      'Extracted Data',
                      style: TextStyle(
                        color: Color(0xFF1F41BB),
                        fontSize: 30,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Make sure the data is correct before you validate it!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Form Fields
                    _buildTextField(
                      label: 'Full Name (Arabic)',
                      controller: arabicNameController,
                      isArabic: true,
                    ),
                    _buildTextField(
                      label: 'Full Name (French)',
                      controller: frenchNameController,
                    ),
                    _buildTextField(
                      label: 'Birthplace (Arabic)',
                      controller: arabicBirthplaceController,
                      isArabic: true,
                    ),
                    _buildTextField(
                      label: 'Birthplace (French)',
                      controller: frenchBirthplaceController,
                    ),
                    _buildTextField(
                      label: 'ID Number',
                      controller: idNumberController,
                    ),
                    _buildTextField(
                      label: 'Birth Date',
                      controller: birthDateController,
                    ),
                    _buildTextField(
                      label: 'Expiry Date',
                      controller: expiryDateController,
                    ),

                    SizedBox(height: 30),

                    // Validate Button
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1F41BB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Validate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}