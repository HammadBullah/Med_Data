class MedicalRecord {
  final int? id;
  final String name;
  final String? aadharNumber;
  final int? age;
  final int? phoneNumber;
  final String? address;
  final String?gender;
  final String? spouseOrFatherName;
  final double? bloodPressure;
  final double? temperature;
  final double? height;
  final double? weight;
  final double? glucoseLevel;

  MedicalRecord({
    required this.id,
    required this.name,
    required this.aadharNumber,
    required this.age,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.spouseOrFatherName,
    required this.bloodPressure,
    required this.temperature,
    required this.height,
    required this.weight,
    required this.glucoseLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'aadharNumber': aadharNumber,
      'age': age,
      'phoneNumber': phoneNumber,
      'address': address,
      'gender': gender,
      'spouseOrFatherName': spouseOrFatherName,
      'bloodPressure': bloodPressure,
      'temperature': temperature,
      'height': height,
      'weight' : weight,
      'glucoseLevel': glucoseLevel,
    };
  }
}
