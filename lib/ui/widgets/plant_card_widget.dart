import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final String plantName;
  final String imageUrl;
  final VoidCallback onTap;



  const PlantCard({
    super.key,
    required this.plantName,
    required this.imageUrl,
    required this.onTap,
  });



  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Fixed width for horizontal scrolling
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 🌿 Background Image (Whole Container)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 180, // Adjust height dynamically
              fit: BoxFit.cover,
            ),
          ),

          // 🌿 Gradient Overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60, // Height of the gradient overlay
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7), // Dark at the bottom
                    Colors.black.withOpacity(0.0), // Transparent at the top
                  ],
                ),
              ),
            ),
          ),

          // 🌿 Text Over Gradient
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Text(
              plantName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Ensures visibility over dark gradient
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
