import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Step {
  final String title;
  final String description;
  final File? media;

  Step({
    required this.title,
    required this.description,
    this.media,
  });
}

class ItineraryView extends StatefulWidget {
  const ItineraryView({Key? key}) : super(key: key);

  @override
  _ItineraryViewState createState() => _ItineraryViewState();
}

class _ItineraryViewState extends State<ItineraryView> {
  File? _img;
  final List<Step> _steps = [];

  Future _takePhoto() async {
    try {
      final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.camera),
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: const Text('Gallery'),
            ),
          ],
        ),
      );

      if (imageSource != null) {
        final image = await ImagePicker().pickImage(source: imageSource);
        if (image != null) {
          setState(() {
            _img = File(image.path);
            _steps.add(Step(
              title: 'Step ${_steps.length + 1}',
              description: 'Description for Step ${_steps.length + 1}',
              media: _img,
            ));
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: OpenStreetMapSearchAndPick(
                center: LatLong(23, 89),
                buttonColor: Colors.blue,
                onPicked: (pickedData) {},
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[200],
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _steps.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _steps.length) {
                      return _buildAddButton();
                    } else {
                      return _buildStepCard(_steps[index]);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        _takePhoto();
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard(Step step) {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.file(
                step.media!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
