import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medical_trigger/medical_database.dart';
import 'package:medical_trigger/medical_record.dart';
import 'package:path_provider/path_provider.dart';

class ExportScreen extends StatefulWidget {
  @override
  _ExportScreenState createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  bool _exporting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export to CSV'),
      ),
      body: Center(
        child: _exporting
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => _exportToCSV(),
                child: Text('Export'),
              ),
      ),
    );
  }

  Future<void> _exportToCSV() async {
    setState(() {
      _exporting = true;
    });

    List<MedicalRecord> records = await MedicalDatabase.instance.getAllRecords();

    final Directory? directory = await getExternalStorageDirectory();
    final String filePath = '${directory!.path}/medical_records.csv';
    final File file = File(filePath);

    // Write headers
    String csvContent = 'Name,Phone Number,Age,Blood Pressure,Temperature,Height,Weight,Glucose Level\n';

    // Write records
    records.forEach((record) {
      Map<String, dynamic> recordMap = {
        'Name': record.name,
        'Phone Number': record.phoneNumber,
        'Age': record.age,
        'Blood Pressure': record.bloodPressure,
        'Temperature': record.temperature,
        'Height': record.height,
        'Weight': record.weight,
        'Glucose Level': record.glucoseLevel,
      };

      csvContent += recordMap.values.map((value) => '$value').join(',') + '\n';
    });

    await file.writeAsString(csvContent);

    setState(() {
      _exporting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exported to $filePath')),
    );
  }
}
