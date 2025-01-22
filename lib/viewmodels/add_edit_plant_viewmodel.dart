import 'package:flutter/material.dart';
import 'package:plantai/data/models/plant.dart';
import 'package:plantai/data/repositories/plant_repository.dart';

class AddEditPlantViewModel extends ChangeNotifier {
  final PlantRepository _plantRepository;
  bool _isLoading = false;
  String? errorMessage;

  AddEditPlantViewModel(this._plantRepository);

  bool get isLoading => _isLoading;

  Future<void> addPlant(Plant plant) async {
    _setLoading(true);

    try {
      await _plantRepository.addPlant(plant);
      _clearError();
    } catch (e) {
      _setError('Failed to add plant: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<List<Plant>> fetchAllPlants() async {
    _setLoading(true);

    try {
      final plants = await _plantRepository.fetchAllPlants();
      _clearError();
      return plants;
    } catch (e) {
      _setError('Failed to fetch plants: ${e.toString()}');
      return [];
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods for state and error management
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
