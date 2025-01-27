import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.pinterest.com%2Fpin%2F606156431091159176%2F&psig=AOvVaw0W5wrCyRzNzv745_fqAMp5&ust=1737827702209000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJigw-r2josDFQAAAAAdAAAAABAI'),
            ),
            title: const Text(
              'Hi, Mark',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Plants',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('View all', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            // My Plants Cards
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  PlantCard(
                      plantName: 'Snake Plant',
                      humidity: '125%',
                      sunlight: 'Sunny',
                      temperature: '90°F'),
                  PlantCard(
                      plantName: 'ZZ Plant',
                      humidity: '125%',
                      sunlight: 'Sunny',
                      temperature: '92°F'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Related Plants Section
            const Text('Related Plants',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Related Plants Cards
            const ListTile(
             
              title: Text('Alberiya Garden Plant'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Plants are predominantly'),
                  Text('Sunny • 90°F', style: TextStyle(color: Colors.grey)),
                ],
              ),
              
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0), 
        child: SizedBox(
          height: 80.0, 
          width: 80.0, 
          child: FloatingActionButton(
            onPressed: () {
             
            },
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  40), 
            ),
            child: SvgPicture.asset(
              'assets/icons/scan.svg', 
              height: 40.0, 
              width: 40.0,
              color: Colors.white, 
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        color: Colors.green,
        borderRadius: BorderRadius.circular(16.0),
       
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(plantName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text('$humidity • $sunlight • $temperature',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
