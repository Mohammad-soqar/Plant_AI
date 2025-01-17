import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantai/ui/views/plant_list_view.dart';
import 'package:plantai/ui/widgets/health_assessment_widget.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/plant_view_model.dart';

class PlantView extends StatelessWidget {
  const PlantView({super.key});

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
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();

                // Show a dialog to choose between gallery and camera
                final result = await showModalBottomSheet<String>(
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Pick from Gallery'),
                        onTap: () => Navigator.pop(context, 'gallery'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('Take a Picture'),
                        onTap: () => Navigator.pop(context, 'camera'),
                      ),
                    ],
                  ),
                );

                // Handle the result from the dialog
                if (result != null) {
                  XFile? image;
                  if (result == 'gallery') {
                    image = await picker.pickImage(source: ImageSource.gallery);
                  } else if (result == 'camera') {
                    image = await picker.pickImage(source: ImageSource.camera);
                  }

                  if (image != null) {
                    // Analyze the selected image
                    viewModel.analyzePlant(File(image.path));
                  }
                }
              },
              child: const Text("Assess Health"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlantListView()),
              );
              },
              child: const Text("Go to My Plants"),
            ),
          ],
        ),
      ),
    );
  }
}
