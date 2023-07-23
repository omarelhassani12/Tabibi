import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tabibi/utils/utils.dart';
import 'package:tabibi/view/screens/patient/main_screen_patient.dart';

Future<List<Message>> fetchMessages(int senderId, int receiverId) async {
  http.Response? response = null;

  try {
    response = await http.get(
      Uri.parse('${Utils.baseUrl}/GetMessages/$senderId/$receiverId'),
    );

    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      if (jsonResponse != null && jsonResponse is List) {
        final List<Message> messages = jsonResponse.map<Message>((message) {
          return Message(
            sender: message['sender_id']?.toString() ?? '',
            receiver: message['receiver_id']?.toString() ?? '',
            message: message['message']?.toString() ?? '',
            time: message['created_at']?.toString() ?? '',
            senderName: '',
            id: message['id'],
          );
        }).toList();

        return messages;
      } else {
        throw Exception('Failed to decode JSON response');
      }
    } else {
      throw Exception('Failed to fetch messages: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching messages: $error');
    print('Response body: ${response?.body}');
    throw Exception('Failed to fetch messages: $error');
  }
}

Future<void> sendMessage(senderId, receiverId, message) async {
  final messageData = {
    'sender_id': senderId,
    'receiver_id': receiverId,
    'message': message,
  };

  try {
    final response = await http.post(
      Uri.parse('${Utils.baseUrl}/messages'),
      body: messageData,
    );

    if (response.statusCode == 200) {
      print('Data inserted successfully');
    } else {
      print('Failed to insert data');
    }
  } catch (error) {
    print('An error occurred: $error');
    throw error; // Rethrow the error to be caught by the caller
  }
}

// Function to fetch the last message between users
Future<Map<String, dynamic>> fetchLastMessage(
    String senderId, String receiverId) async {
  final url = '${Utils.baseUrl}/LastMessage/$senderId/$receiverId';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Request succeeded, parse the response JSON
      final lastMessage = json.decode(response.body);
      return lastMessage as Map<String, dynamic>;
    } else if (response.statusCode == 404) {
      // No last message found
      print('No last message found');
      return {'error': 'No last message found'};
    } else {
      // Request failed with an error
      print('Failed to fetch last message. Error: ${response.statusCode}');
      return {'error': 'Failed to fetch last message'};
    }
  } catch (error) {
    // Request failed with an exception
    print('Failed to fetch last message. Error: $error');
    return {'error': 'Failed to fetch last message'};
  }
}
