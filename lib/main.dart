import 'package:flutter/material.dart';
import 'package:plantai/data/repositories/plant_repository.dart';
import 'package:plantai/ui/views/home_page.dart';
import 'package:plantai/ui/views/plant_list_view.dart';
import 'package:plantai/viewmodels/add_edit_plant_viewmodel.dart';
import 'package:plantai/viewmodels/plant_list_viewmodel.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'ui/views/plant_view.dart';
import 'viewmodels/plant_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 // Instantiate the repository
  final plantRepository = PlantRepository();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlantViewModel()),
        ChangeNotifierProvider(create: (_) => PlantListViewmodel()),
        ChangeNotifierProvider(create: (_) => AddEditPlantViewModel(plantRepository)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
