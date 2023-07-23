import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tabibi/utils/utils.dart';

Future<List<dynamic>> fetchResponseData(String suburganceid) async {
  final url = '${Utils.baseUrl}/response/$suburganceid';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data as List<dynamic>;
  } else {
    throw Exception('Failed to fetch response data');
  }
}
