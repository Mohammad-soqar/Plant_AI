import 'package:flutter/material.dart';

class DiseaseDetailsView extends StatelessWidget {
  final Map<String, dynamic> disease;

  const DiseaseDetailsView({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(disease['name'] ?? "Disease Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              disease['name'] ?? "Unknown Disease",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Description: ${disease['description'] ?? "Description not available."}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              "Solution: ${disease['solution'] ?? "Solution not available."}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Cause: ${disease['cause'] ?? "Cause not available."}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
