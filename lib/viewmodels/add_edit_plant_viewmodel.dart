import 'package:flutter/material.dart';
import 'package:plantai/data/models/plant.dart';
import 'package:plantai/data/services/plant_service.dart';


class AddEditPlantViewModel extends ChangeNotifier {
  final PlantService _plantService = PlantService();
  late Plant _plant;
  bool _isLoading = false;



 
}