import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plantai/ui/widgets/Diseases_List_widget.dart';
import 'package:plantai/ui/widgets/similar_images_grid_widget.dart';
import 'package:plantai/viewmodels/plant_view_model.dart';

class HealthAssessmentSection extends StatelessWidget {
  final PlantViewModel viewModel;

  const HealthAssessmentSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Plant Name: ${viewModel.plantName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (viewModel.healthStatus!.toLowerCase() == "diseased")
              Text(
                "Health Status: ${viewModel.healthStatus}",
                style: const TextStyle(fontSize: 14),
              ),
            const SizedBox(height: 20),
            DiseasesList(diseases: viewModel.diseases),
            const SizedBox(height: 20),
            SimilarImagesGrid(similarImages: viewModel.similarImages),
          ],
        ),
      ),
    );
  }
}
