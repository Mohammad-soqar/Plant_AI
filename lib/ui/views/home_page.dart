import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantai/ui/views/plant_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/background.mp4")
      ..initialize().then((_) {
        print("Video Initialized: ${_controller.value.isInitialized}");
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      }).catchError((error) {
        print("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final result = await showModalBottomSheet<String>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
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
        ),
      );

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
              ),
            ),
          );
        }
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background video layer
        Positioned.fill(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        // Overlay to darken the video (optional)
        Container(color: Colors.black.withOpacity(0.3)),
        // Scaffold with transparent background, displaying the AppBar and content
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'PlantAI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            centerTitle: true,
            backgroundColor: Colors.transparent, // Fully transparent
            elevation: 0.0, // No shadow
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF000000), // Black at the top
                    Color(0xFF000000), // Black at the top
                    Color.fromARGB(0, 0, 0, 0), // Fully transparent black
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: FloatingActionButton(
                    onPressed: _pickImage,
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
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ],
    );
  }
}
