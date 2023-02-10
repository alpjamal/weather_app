import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> extractedData = json.decode(response.body);
        return extractedData;
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      if (e.runtimeType == int) rethrow;
      throw 'Unknown';
    }
  }
}
