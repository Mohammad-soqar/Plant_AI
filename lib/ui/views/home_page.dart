import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantai/ui/views/plant_view.dart';
import 'package:plantai/ui/widgets/plant_card_widget.dart';
import 'package:plantai/viewmodels/plant_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PlantViewModel>(context);
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
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Plants',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('View all', style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(height: 10),
            // My Plants Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PlantCard(
                    plantName: 'Snake Plant',
                    humidity: '125%',
                    sunlight: 'Sunny',
                    temperature: '90°F',
                  ),
                   PlantCard(
                    plantName: 'Snake Plant',
                    humidity: '125%',
                    sunlight: 'Sunny',
                    temperature: '90°F',
                  ),
                  PlantCard(
                    plantName: 'ZZ Plant',
                    humidity: '125%',
                    sunlight: 'Sunny',
                    temperature: '92°F',
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            // Related Plants Section
            Text('Related Plants',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // Related Plants Cards
            ListTile(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlantView(
                              plantPicture: image!,
                            )),
                  );
                }
              }
            },
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
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
