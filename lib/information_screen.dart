import 'package:flutter/material.dart';
import 'package:medical_trigger/medical_database.dart';
import 'package:medical_trigger/medical_record.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: FutureBuilder<List<MedicalRecord>>(
        future: MedicalDatabase.instance.getAllRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<MedicalRecord> records = snapshot.data!;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                MedicalRecord record = records[index];
                return GestureDetector(
                  onTap: () => _showDetailsDialog(context, record),
                  child: Card(
                    color: Colors.blue.withOpacity(0.5),
                    child: ListTile(
                      title: Text(
                        record.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Phone Number: ${record.phoneNumber ?? 'N/A'}'),
                          Text('Age: ${record.age ?? 'N/A'}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, MedicalRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Details for ${record.name}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Phone Number: ${record.phoneNumber ?? 'N/A'}'),
            Text('Age: ${record.age ?? 'N/A'}'),
            Text('Blood Pressure: ${record.bloodPressure ?? 'N/A'}'),
            Text('Temperature: ${record.temperature ?? 'N/A'}'),
            Text('Height: ${record.height ?? 'N/A'}'),
            Text('Weight: ${record.weight ?? 'N/A'}'),
            Text('Glucose Level: ${record.glucoseLevel ?? 'N/A'}'),
            // Add more fields here as needed
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
