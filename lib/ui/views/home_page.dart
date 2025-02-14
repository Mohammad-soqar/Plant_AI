import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantai/ui/views/plant_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/background.jpg"), // Ensure the image is in assets
            fit: BoxFit.cover, // Covers the entire screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Scan a Plant',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
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
                        image =
                            await picker.pickImage(source: ImageSource.gallery);
                      } else if (result == 'camera') {
                        image =
                            await picker.pickImage(source: ImageSource.camera);
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
