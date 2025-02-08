import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantai/ui/widgets/health_assessment_widget.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/plant_view_model.dart';

class PlantView extends StatefulWidget {
  final XFile plantPicture;

  const PlantView({super.key, required this.plantPicture});

  @override
  State<PlantView> createState() => _PlantViewState();
}

class _PlantViewState extends State<PlantView> {
  late PlantViewModel viewModel;

 @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    viewModel = Provider.of<PlantViewModel>(context, listen: false);

    // Convert XFile to File
    final File plantFile = File(widget.plantPicture.path);
    viewModel.analyzePlant(plantFile);
  });
}
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PlantViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Plant AI")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else if (viewModel.errorMessage != null)
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (viewModel.healthStatus != null)
              HealthAssessmentSection(viewModel: viewModel)
            else
              const Text("No health assessment yet."),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
