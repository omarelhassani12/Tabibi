import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tabibi/utils/utils.dart';

Future<Map<String, dynamic>> userLogin(String email, String password) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/user/login'),
    headers: {"Content-Type": "application/json;charset=UTF-8"},
    body: jsonEncode({'email': email, 'password': password}),
  );
  print('ffff');
  final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
  print(decodedData);

  return decodedData;
}

Future<Map<String, dynamic>> userRegister(
    String type,
    String nomPrenom,
    String email,
    String cni,
    String password,
    String telephone,
    String urgence,
    String sexe,
    String age) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/user/register'),
    headers: {"Content-Type": "application/json;charset=UTF-8"},
    body: jsonEncode({
      'type': type,
      'nomPrenom': nomPrenom,
      'email': email,
      'cni': cni,
      'password': password,
      'telephone': telephone,
      'urgence': urgence,
      'sexe': sexe,
      'age': age,
    }),
  );

  var decodedData = jsonDecode(response.body);
  if (decodedData['success'] == false &&
      decodedData['message'].toString().contains('Duplicate entry')) {
    return {
      'success': false,
      'message':
          'The email you entered is already in use. Please try with a different email address.'
    };
  } else {
    return decodedData;
  }
}
