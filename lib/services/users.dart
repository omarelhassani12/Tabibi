import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

Future<List<dynamic>> fetchDoctors() async {
  final response = await http.get(Uri.parse('${Utils.baseUrl}/doctors'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    if (jsonData['success'] == true && jsonData['users'] is List) {
      List<dynamic> fetchedDoctors = jsonData['users'];
      print(fetchedDoctors);
      return fetchedDoctors;
    } else {
      throw Exception('Invalid response: doctors data is not a list');
    }
  } else {
    throw Exception(
        'Failed to fetch doctors. Status code: ${response.statusCode}');
  }
}

Future<Map<String, dynamic>?> getUserData(String userid) async {
  try {
    final response =
        await http.get(Uri.parse('${Utils.baseUrl}/GetUserData/$userid'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data as Map<String, dynamic>;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to fetch user data');
    }
  } catch (error) {
    print('Error: $error');
    return null;
  }
}

//for update user profile

Future<void> uploadProfileData(
  int userId,
  Map<String, dynamic> profileData,
  String? base64Image,
) async {
  var url = Uri.parse('${Utils.baseUrl}/editprofile/$userId');

  try {
    var request = http.MultipartRequest('PUT', url);

    if (base64Image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('imageProfil', base64Image),
      );
    }

    if (profileData.isNotEmpty) {
      request.fields.addAll(profileData.cast<String, String>());
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Votre profil a été modifié avec succès',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 17.0,
        );
      } else {
        var responseBody = await response.stream.bytesToString();
        print('Échec du téléchargement de l\'image. Erreur : $responseBody');
        Fluttertoast.showToast(
          msg: 'Échec du téléchargement de l\'image. Erreur : $responseBody',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 17.0,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: 'Erreur lors de la mise à jour des données du profil',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 17.0,
      );
    }
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
      msg: 'Erreur lors de la création de la requête',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
    );
  }
}
