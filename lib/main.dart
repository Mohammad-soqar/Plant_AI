import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/views/plant_view.dart';
import 'viewmodels/plant_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlantViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlantView(),
    );
  }
}
