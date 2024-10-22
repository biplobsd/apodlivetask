import 'package:http/http.dart' as http;
import 'package:apodlivetask/model/apod.dart';

const String baseUrl = 'https://api.nasa.gov/planetary/apod';
const String apiKey = '18QBwoiRpbFgeYBSl3PxFHi2aoJjrt7lIindJfng';

class Api {
  Future<Apod> getData(String? date) async {
    var apiUrl = '$baseUrl?api_key=$apiKey';

    if (date != null) {
      apiUrl = '$apiUrl&date=$date';
    }

    try {
      final res = await http.get(Uri.parse(apiUrl));

      if (res.statusCode == 200) {
        return Apod.fromJson(res.body);
      }

      throw Exception('Http Exception code: ${res.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}
