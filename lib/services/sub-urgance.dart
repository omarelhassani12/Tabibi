import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabibi/utils/utils.dart';

Future<List<dynamic>> fetchSubUrgances(int urganceId) async {
  final url = '${Utils.baseUrl}/sub-urgances/$urganceId';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Failed to fetch sub-urgances');
  }
}
