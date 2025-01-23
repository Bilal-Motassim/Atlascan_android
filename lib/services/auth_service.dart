import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  static const String baseUrl = "http://13.40.214.118:8080/api/auth";

// Register user
Future<String> registerUser(Map<String, dynamic> registerData) async {
  final response = await http.post(
    Uri.parse('$baseUrl/register'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(registerData),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');  // Add this line to inspect the response

  if (response.statusCode == 200) {
    try {
      return response.body;  // Attempt to parse the JSON
    } catch (e) {
      return 'Error parsing response: $e';
    }
  } else {
    return "Failed to register user: ${response.body}";
  }
}





  // Login user
  Future<User?> loginUser(Map<String, dynamic> loginData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/normal-login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(loginData),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return User.fromJson(responseData); 
    } else {
      return null; 
    }
  }
}
