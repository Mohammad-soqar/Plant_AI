import 'package:flutter/material.dart';
import 'package:plantai/ui/widgets/plant_list_card_widget.dart';
import 'package:plantai/viewmodels/plant_list_viewmodel.dart';
import 'package:provider/provider.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PlantListViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant List"),
      ),
      body: FutureBuilder(
        future: viewModel.getPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage ?? "Something went wrong",
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (viewModel.plants.isEmpty) {
            return const Center(
              child: Text("No plants available."),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: viewModel.plants.length,
            itemBuilder: (context, index) {
              final plant = viewModel.plants[index];
              return PlantListCard(
                plantName: plant.plantName,
                imageUrl: plant.imageUrl,


                
                onTap: () {
                  // Handle card tap (e.g., navigate to a details page)
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(plant.plantName),
                      content: Text("More details about ${plant.plantName}"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
