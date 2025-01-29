import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plantai/data/services/plant_api_service.dart';

class PlantViewModel extends ChangeNotifier {
  final PlantApiServices _plantApiServices = PlantApiServices();

  String? plantName; // To store the plant name
  String? plantDescription; // To store the plant name
  int? plantWateringstr; // To store the plant name
  String? healthStatus; // To store plant health status
  String? pickedImagePath;
  List<Map<String, dynamic>> diseases = [];
  List<String> similarImages = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> analyzePlant(File imageFile) async {
    try {
      // Convert image to Base64
      final bytes = imageFile.readAsBytesSync();
      final base64Image = base64Encode(bytes);
      pickedImagePath = imageFile.path;

      // Set loading state
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Call Identify API to get plant name
      final identifyResponse = await _plantApiServices.identifyPlant(
        base64Images: [base64Image],
      );

      if (identifyResponse['is_plant'] == true) {
        plantName = identifyResponse['suggestions']?[0]?['plant_name'] ??
            "Unknown Plant";
        plantDescription = identifyResponse['suggestions']?[0]?['plant_details']
                ?["wiki_description"]?["value"] ??
            "Unknown Plant";
        plantWateringstr = identifyResponse['suggestions']?[0]?['plant_details']
                ?["watering"]?["min"] ??
            0;
        similarImages = identifyResponse['suggestions']?[0] 
                    ?['similar_images'] !=
                null
            ? (identifyResponse['suggestions']?[0]?['similar_images'] as List)
                .map((image) => image['url'] as String)
                .toList()
            : [];
      } else {
        plantName = "Not a plant";
        similarImages = [];
      }

      // Call Health Assessment API to get diseases and health status
      final healthResponse = await _plantApiServices.assessPlantHealth(
        base64Images: [base64Image],
      );

      final healthAssessment = healthResponse['health_assessment'];
      if (healthAssessment != null) {
        healthStatus =
            healthAssessment['is_healthy'] == true ? "Healthy" : "Diseased";

        // Extract diseases
        final diseaseSuggestions = healthAssessment['diseases'] as List?;
        if (diseaseSuggestions != null && diseaseSuggestions.isNotEmpty) {
          diseases = diseaseSuggestions
              .take(2) // Limit to 2 diseases
              .map((disease) => {
                    "name": disease['name'] ?? "Unknown Disease",
                    "description": disease['disease_details']?['description'] ??
                        "No description available.",
                    "solution": disease['disease_details']?['treatment'] ??
                        "No solution available.",
                    "similar_images": (disease['similar_images'] as List?)
                        ?.map((image) => image['url'] as String)
                        .toList(),
                  })
              .toList();
        } else {
          diseases = [];
        }
      } else {
        healthStatus = "No health assessment found";
        diseases = [];
      }
    } catch (e) {
      errorMessage = "Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
