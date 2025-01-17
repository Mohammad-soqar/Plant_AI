import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final String plantName;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.plantName,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plant image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 80),
                ),
              ),
              const SizedBox(width: 12),
              // Plant details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plantName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
