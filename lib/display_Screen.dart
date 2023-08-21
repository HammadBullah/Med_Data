import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class DisplayScreen extends StatelessWidget {
  final List<Map<String, String>> dataList;

  DisplayScreen(this.dataList);

  Future<void> _shareData() async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Sheet1'];

    // Add header row
    sheet.appendRow(['Name', 'Age', 'Height', 'Weight', 'Blood Pressure', 'Heart Rate', 'Temperature']);

    // Add data rows
    for (var data in dataList) {
      sheet.appendRow([
        data['Name'],
        data['Age'],
        data['Height'],
        data['Weight'],
        data['Blood Pressure'],
        data['Heart Rate'],
        data['Temperature'],
      ]);
    }

    final directory = await getExternalStorageDirectory();
    final excelFile = File('${directory!.path}/data.xlsx');
    final excelBytes = excel.encode();
    await excelFile.writeAsBytes(excelBytes!);

    await Share.shareFiles([excelFile.path], text: 'Sharing Excel Sheet');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stored Data'),
        backgroundColor: Colors.red[300],
      ),

      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          var data = dataList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: ListTile(
                title: Text(
                  'Name: ${data['Name']}',
                  style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age: ${data['Age']}',
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      'Height: ${data['Height']}',
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      'Weight: ${data['Weight']}',
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      'Blood Pressure: ${data['Blood Pressure']}',
                      style: GoogleFonts.montserrat(),
                    ),

                    Text(
                      'Heart Rate: ${data['Heart Rate']}',
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      'Temerature: ${data['Temperature']}',
                      style: GoogleFonts.montserrat(),
                    ),
                    // Add other fields as needed
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _shareData,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red[300]!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
              Size(double.infinity, 50.0),
            ),
          ),
          child: Text('Share File', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
