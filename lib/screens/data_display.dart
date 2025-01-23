import 'package:flutter/material.dart';

class DataDisplayScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DataDisplayScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data); // For debugging purposes

    // Safely access 'structured_data'
    final structuredData = data['structured_data'] as Map<String, dynamic>?;

    if (structuredData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Extracted Data'),
        ),
        body: Center(
          child: Text('No structured data available.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Extracted Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 8),
            if (structuredData['Prénom'] != null)
              _buildDataItem('First Name', structuredData['Prénom']),
            if (structuredData['Nom de famille'] != null)
              _buildDataItem('Last Name', structuredData['Nom de famille']),
            if (structuredData['Date de naissance'] != null)
              _buildDataItem('Date of Birth', structuredData['Date de naissance']),
            if (structuredData['Lieu de naissance'] != null)
              _buildDataItem('Place of Birth', structuredData['Lieu de naissance']),
            if (structuredData['Num d\'identité'] != null)
              _buildDataItem('Identity Number', structuredData['Num d\'identité']),
            if (structuredData['Valable jusqu\'au'] != null)
              _buildDataItem('Valid Until', structuredData['Valable jusqu\'au']),
            
            if (structuredData['Adresse'] != null)
              _buildDataItem('Address', structuredData['Adresse']),
            
            if (structuredData['Numéro de permis'] != null)
              _buildDataItem('Driver license number', structuredData['Numéro de permis']),

              if (structuredData['Numéro de passport'] != null)
              _buildDataItem('Passport number', structuredData['Numéro de passport']),

            
            if (structuredData['Date d\'expiration'] != null)
              _buildDataItem('Expiration date', structuredData['Date d\'expiration']),
            
            if (structuredData['Nationalité'] != null)
              _buildDataItem('Nationality', structuredData['Nationalité']),
          ],
        ),
      ),
    );
  }

  Widget _buildDataItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}
