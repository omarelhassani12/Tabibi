import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabibi/utils/utils.dart';

Future<List<dynamic>> fetchPatients() async {
  final response = await http.get(Uri.parse('${Utils.baseUrl}/patients'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    if (jsonData['success'] == true && jsonData['users'] is List) {
      List<dynamic> fetchedPatients = jsonData['users'];
      print(fetchedPatients);
      return fetchedPatients;
    } else {
      throw Exception('Invalid response: patients data is not a list');
    }
  } else {
    throw Exception(
        'Failed to fetch patients. Status code: ${response.statusCode}');
  }
}
