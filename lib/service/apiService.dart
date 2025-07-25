
import 'dart:convert';
import 'package:http/http.dart' as http;

class Apiservice {

  static const String baseUrl = 'http://10.0.2.2:3000';

  // Example method to fetch data from an API
  static Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 418) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Example method to post data to an API
  static Future<Map<String, dynamic>> postData(String endpoint, String data) async {

    final url = Uri.parse('$baseUrl/$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Host': url.host,
      'Content-Length': data.length.toString(),
    };
    final response = await http.post(
      url,
      headers: headers,
      body: data,
    );

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}