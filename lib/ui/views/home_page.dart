import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.pinterest.com%2Fpin%2F606156431091159176%2F&psig=AOvVaw0W5wrCyRzNzv745_fqAMp5&ust=1737827702209000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJigw-r2josDFQAAAAAdAAAAABAI'),
        ),
        title: const Text(
          'Hi, Mark\nGood Morning',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceChip(label: const Text('Indoor'), selected: true),
                ChoiceChip(label: const Text('Outdoor'), selected: false),
                ChoiceChip(label: const Text('Both'), selected: false),
              ],
            ),
            const SizedBox(height: 20),
            // My Plants Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('My Plants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('View all', style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 10),
            // My Plants Cards
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PlantCard(plantName: 'Snake Plant', humidity: '125%', sunlight: 'Sunny', temperature: '90°F'),
                  PlantCard(plantName: 'ZZ Plant', humidity: '125%', sunlight: 'Sunny', temperature: '92°F'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Related Plants Section
            const Text('Related Plants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Related Plants Cards
            ListTile(
              leading: const Image(
                image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.pinterest.com%2Fpin%2F606156431091159176%2F&psig=AOvVaw0W5wrCyRzNzv745_fqAMp5&ust=1737827702209000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJigw-r2josDFQAAAAAdAAAAABAI'),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              title: const Text('Alberiya Garden Plant'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Plants are predominantly'),
                  Text('Sunny • 90°F', style: TextStyle(color: Colors.grey)),
                ],
              ),
              trailing: const Text('\$25.55', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String plantName;
  final String humidity;
  final String sunlight;
  final String temperature;

  const PlantCard({
    super.key,
    required this.plantName,
    required this.humidity,
    required this.sunlight,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          const SizedBox(height: 10),
          Text(plantName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text('$humidity • $sunlight • $temperature', style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
