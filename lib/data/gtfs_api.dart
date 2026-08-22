import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GtfsApi {
  static const String baseUrl = 'https://api.data.gov.my';

  Future<Uint8List> downloadKtmb() async {
    final uri = Uri.parse('$baseUrl/gtfs-static/ktmb');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('KTMB GTFS download failed: ${response.statusCode}');
    }

    return response.bodyBytes;
  }

  Future<Uint8List> downloadRapidRail() async {
    final uri = Uri.parse(
      '$baseUrl/gtfs-static/prasarana',
    ).replace(queryParameters: {'category': 'rapid-rail-kl'});

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Rapid Rail GTFS download failed: ${response.statusCode}',
      );
    }

    return response.bodyBytes;
  }
}
