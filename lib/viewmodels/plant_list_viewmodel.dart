import 'package:flutter/material.dart';
import 'package:plantai/data/models/plant.dart';
import 'package:plantai/data/repositories/plant_repository.dart';

class PlantListViewmodel extends ChangeNotifier {
  final PlantRepository _plantRepository = PlantRepository();

  List<Plant> plants = [];
  String? errorMessage;
  Future<List<Plant>>? _cachedPlantsFuture; // Cache the Future

  Future<List<Plant>> getPlants() async {
    if (_cachedPlantsFuture == null) {
      _cachedPlantsFuture = _fetchPlants();
    }
    return _cachedPlantsFuture!;
  }

  Future<List<Plant>> _fetchPlants() async {
    try {
      plants = await _plantRepository.fetchAllPlants();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      plants = [];
    }
    return plants;
  }
}
