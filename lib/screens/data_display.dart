import 'package:flutter/material.dart';

class DataDisplayScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DataDisplayScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text('Extracted Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Arabic Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildDataItem('Date of Birth', data['extracted_data']?['arabic']?['date_naissance']),
            _buildDataItem('Place of Birth', data['extracted_data']?['arabic']?['lieu_naissance']),
            _buildDataItem('Full Name', data['extracted_data']?['arabic']?['nom_complet']),
            _buildDataItem('CIN Number', data['extracted_data']?['arabic']?['num_cni']),
            Divider(),
            Text(
              'French Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildDataItem('Expiration Date', data['extracted_data']?['french']?['date_expiration']),
            _buildDataItem('Date of Birth', data['extracted_data']?['french']?['date_naissance']),
            _buildDataItem('Place of Birth', data['extracted_data']?['french']?['lieu_naissance']),
            _buildDataItem('Full Name', data['extracted_data']?['french']?['nom_complet']),
            _buildDataItem('CIN Number', data['extracted_data']?['french']?['num_cni']),
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
