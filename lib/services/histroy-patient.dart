import 'package:http/http.dart' as http;
import 'package:tabibi/utils/utils.dart';

Future<void> insertPatientHistorique(
    int patientId, String urgencyId, DateTime dateTime) async {
  final url = '${Utils.baseUrl}/patient-history'; // Replace with your server URL

  final body = {
    'userId': patientId.toString(),
    'urganceId': urgencyId,
    'timestamp': dateTime.toIso8601String(),
  };

  try {
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      print('Patient history inserted successfully');
    } else {
      print('Error inserting patient history: ${response.body}');
    }
  } catch (e) {
    print('Error inserting patient history: $e');
  }
}
