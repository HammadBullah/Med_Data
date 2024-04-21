import 'package:flutter/material.dart';
import 'package:medical_trigger/export_screen.dart';
import 'package:medical_trigger/medical_database.dart' as medical_db; // Import with alias
import 'package:medical_trigger/medical_record.dart';

import 'information_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Diagnosis App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Information'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformationScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Export to Excel'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExportScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: MedicalForm(),
    );
  }
}

class MedicalForm extends StatefulWidget {
  @override
  _MedicalFormState createState() => _MedicalFormState();
}

class _MedicalFormState extends State<MedicalForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController spouseOrFatherNameController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController glucoseLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Diagnosis Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Information:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: idController,
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: aadharNumberController,
                decoration: InputDecoration(labelText: 'Aadhar Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Aadhar number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Phone Number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: spouseOrFatherNameController,
                decoration: InputDecoration(labelText: 'Spouse/Father Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your spouse/father name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0),
              Text(
                'Medical Data:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: bloodPressureController,
                decoration: InputDecoration(labelText: 'Blood Pressure'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your blood pressure';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: temperatureController,
                decoration: InputDecoration(labelText: 'Temperature'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your temperature';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: glucoseLevelController,
                decoration: InputDecoration(labelText: 'Glucose Level'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your glucose level';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Save form data
                      _formKey.currentState!.save();
                      // Create MedicalRecord object
                      MedicalRecord record = MedicalRecord(
                        id: int.parse(idController.text),
                        name: nameController.text,
                        aadharNumber: aadharNumberController.text,
                        age: int.parse(ageController.text),
                        address: addressController.text,
                        gender: genderController.text,
                        spouseOrFatherName: spouseOrFatherNameController.text,
                        bloodPressure: double.parse(bloodPressureController.text),
                        temperature: double.parse(temperatureController.text),
                        height: double.parse(heightController.text),
                        weight: double.parse(weightController.text),
                        glucoseLevel: double.parse(glucoseLevelController.text),
                        phoneNumber: int.parse(phoneController.text),
                      );
                      // Convert MedicalRecord object to Map
                      Map<String, dynamic> recordMap = record.toMap();
                      // Insert or update record in the database
                      await medical_db.MedicalDatabase.instance.getAllRecords();
                      // Clear form fields
                      idController.clear();
                      nameController.clear();
                      aadharNumberController.clear();
                      ageController.clear();
                      addressController.clear();
                      genderController.clear();
                      spouseOrFatherNameController.clear();
                      bloodPressureController.clear();
                      temperatureController.clear();
                      heightController.clear();
                      weightController.clear();
                      glucoseLevelController.clear();
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Record saved successfully!'),
                        duration: Duration(seconds: 2),
                      ));
                    } catch (e) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error: $e'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
