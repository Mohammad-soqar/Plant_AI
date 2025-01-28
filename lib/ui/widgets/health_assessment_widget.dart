import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plantai/ui/widgets/Diseases_List_widget.dart';
import 'package:plantai/ui/widgets/similar_images_grid_widget.dart';
import 'package:plantai/viewmodels/plant_view_model.dart';

class HealthAssessmentSection extends StatelessWidget {
  final PlantViewModel viewModel;

  const HealthAssessmentSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    String limitedText = viewModel.plantDescription!.contains(".")
        ? viewModel.plantDescription!.split(".")[0] + "."
        : viewModel.plantDescription!;

    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (viewModel.pickedImagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(viewModel.pickedImagePath!),
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            if (viewModel.plantName != null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "${viewModel.plantName}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      limitedText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Opacity(
                        opacity: (index < viewModel.plantWateringstr!)
                            ? 1.0
                            : 0.3, // Full opacity for active emojis, low opacity for inactive
                        child: const Text(
                          '💧',
                          style: TextStyle(
                              fontSize: 16), // Adjust font size as needed
                        ),
                      );
                    }),
                  ),
                ],
              ),
            if (viewModel.healthStatus != null &&
                viewModel.healthStatus!.toLowerCase() == "diseased")
              Text(
                "Health Status: ${viewModel.healthStatus}",
                style: const TextStyle(fontSize: 14),
              ),
            const SizedBox(height: 20),
            if (viewModel.healthStatus!.toLowerCase() == "diseased")
              DiseasesList(diseases: viewModel.diseases),
            const SizedBox(height: 20),
            SimilarImagesGrid(similarImages: viewModel.similarImages),
          ],
        ),
      ),
    );
  }
}
