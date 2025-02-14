  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantai/data/models/plant.dart';

class PlantService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'plant';


  // 1: Implement the getPlants method to fetch all plants from Firestore
  Future<List<Plant>> getPlants() async {
    QuerySnapshot snapshot = await _firestore.collection(collection).get();
    print(snapshot.docs.map((doc) => Plant.fromSnap(doc)).toList());
    return snapshot.docs.map((doc) => Plant.fromSnap(doc)).toList();
  }

  // 2: Implement the getPlant method
  Future<Plant> getPlantById(String plantId) async {
    DocumentSnapshot snapshot = await _firestore.collection(collection).doc(plantId).get();
    return Plant.fromSnap(snapshot);
  }

  // 3: Implement the addPlant method
  Future addPlant(Plant plant) async {
    await   _firestore.collection(collection).add(plant.toJson());  
  }

  // 4: Implement the updatePlant method
  Future<void> updatePlant(Plant plant) async {
    await _firestore.collection(collection).doc(plant.plantId).update(plant.toJson());
  }

  // 5: Implement the deletePlant method
  Future<void> deletePlant(String plantId) async {
    await _firestore.collection(collection).doc(plantId).delete();
  }

}