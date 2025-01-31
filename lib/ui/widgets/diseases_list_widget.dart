import 'package:flutter/material.dart';
import 'package:plantai/ui/views/plant_management/disease_details_view.dart';

class DiseasesList extends StatelessWidget {
  final List<Map<String, dynamic>> diseases;

  const DiseasesList({super.key, required this.diseases});

  @override
  Widget build(BuildContext context) {
    if (diseases.isEmpty) {
      return const Center(
        child: Text("No diseases found.", style: TextStyle(fontSize: 16)),
      );
    }



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: diseases.map((disease) {
        return ListTile(
          title: Text(
            disease['name'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(maxLines: 2,
            style: const TextStyle(fontSize: 14),
            disease['description']),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiseaseDetailsView(disease: disease),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
