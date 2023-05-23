import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tabibi/utils/utils.dart';

Future<List<dynamic>> fetchUrgances() async {
  final response = await http.get(Uri.parse('${Utils.baseUrl}/urgance'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['success']) {
      return data['urgances'];
      print(data['urgance']);
    } else {
      throw Exception(data['message']);
    }
  } else {
    throw Exception('Failed to fetch urgances');
  }
}
