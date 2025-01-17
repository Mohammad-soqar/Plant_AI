import 'package:plantai/data/models/plant.dart';
import 'package:plantai/data/services/plant_service.dart';

class PlantRepository {
  final PlantService _plantService = PlantService();

  Future<List<Plant>> fetchAllPlants() async{
    try{
      return _plantService.getPlants();
    } catch(e){
      throw Exception('Failed to fetch plants: $e');
    }
  }

  Future<Plant> fetchPlant(String plantId) async{
    try{
      return _plantService.getPlantById(plantId);
    } catch(e){
      throw Exception('Failed to fetch plant: $e');
    }
  }

  Future<void> addPlant(Plant plant) async{
    try{
      return _plantService.addPlant(plant);
    } catch(e){
      throw Exception('Failed to add plant: $e');
    }
  }

  Future<void> updatePlant(Plant plant) async{
    try{
      return _plantService.updatePlant(plant);
    } catch(e){
      throw Exception('Failed to update plant: $e');
    }
  }

  Future<void> deletePlant(String plantId) async{
    try{
      return _plantService.deletePlant(plantId);
    } catch(e){
      throw Exception('Failed to delete plant: $e');
    }
  }
}