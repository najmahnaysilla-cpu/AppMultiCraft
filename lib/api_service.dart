import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Gunakan IP lokal Wi-Fi rumah kamu saat ini
  static const String baseUrl = 'http://192.168.1.9/multicraft/api/';

  // Fungsi untuk Login
  static Future login(String identifier, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}login.php'),
        body: {
          'identifier': identifier,
          'password': password,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        "status": "error",
        "message": "Gagal terhubung ke server: $e"
      };
    }
  }

  // Fungsi untuk Register
  static Future register(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}register.php'),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        "status": "error",
        "message": "Gagal terhubung ke server: $e"
      };
    }
  }
}