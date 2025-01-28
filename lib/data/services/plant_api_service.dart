import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plantai/utils/env.dart';

class PlantApiServices {
  final String identifyUrl = "https://api.plant.id/v2/identify";
  final String healthAssessmentUrl =
      "https://api.plant.id/v2/health_assessment";
  final String apiKey = Env.plantIdApiKey;

  // Method to identify plant and get plant name
  Future<Map<String, dynamic>> identifyPlant({
    required List<String> base64Images,
    String language = "en",
  }) async {
    final payload = {
      "api_key": apiKey,
      "images": base64Images,
      "plant_details": ["common_names","taxonomy","edible_parts","watering", "url", "wiki_description"],
      "language": language,
      "modifiers": ["similar_images"],
    };

    try {
      final response = await http.post(
        Uri.parse(identifyUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload),
      );

      final responseBody = response.body;
      final pattern =
          RegExp('.{1,800}'); // Split the string into 800-character chunks
      pattern
          .allMatches(responseBody)
          .forEach((match) => print(match.group(0)));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedBody = jsonDecode(response.body);
        print("Parsed Identify JSON: $decodedBody");
        return decodedBody;
      } else {
        throw Exception(
          "Failed to identify plant: Status Code ${response.statusCode}, Body: ${response.body}",
        );
      }
    } catch (e) {
      print("Error identifying plant: $e");
      rethrow;
    }
  }

  // Method to assess plant health
  Future<Map<String, dynamic>> assessPlantHealth({
    required List<String> base64Images,
    double? latitude,
    double? longitude,
    String language = "en",
  }) async {
    final payload = {
      "api_key": apiKey,
      "images": base64Images,
      "language": language,
      "modifiers": ["similar_images"], // Enable similar images in the response
      "disease_details": [
        "cause",
        "common_names",
        "classification",
        "description",
        "treatment",
        "url"
      ],
      "latitude": latitude,
      "longitude": longitude,
    };

    try {
      final response = await http.post(
        Uri.parse(healthAssessmentUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload),
      );

      print("Health Assessment Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedBody = jsonDecode(response.body);
        print("Parsed Health JSON: $decodedBody");
        return decodedBody;
      } else {
        throw Exception(
          "Failed to assess plant health: Status Code ${response.statusCode}, Body: ${response.body}",
        );
      }
    } catch (e) {
      print("Error assessing plant health: $e");
      rethrow;
    }
  }
}
