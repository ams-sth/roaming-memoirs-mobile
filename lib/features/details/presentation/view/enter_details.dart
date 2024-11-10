import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_log/features/auth/domain/entity/user_entity.dart';
import 'package:travel_log/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';
import 'package:travel_log/features/details/presentation/view/detail_view_model.dart';

import '../../../../config/router/app_route.dart';

class EnterDetails extends ConsumerStatefulWidget {
  const EnterDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends ConsumerState<EnterDetails> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(detailViewModelProvider.notifier).uploadCoverPhoto(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final _saveKey = GlobalKey<FormState>();

  final gap = const SizedBox(height: 10);
  final TextEditingController _tripNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  Future<void> _selectStartDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
        _startDateController.text = _formatDate(_selectedStartDate!);
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedDate;
        _endDateController.text = _formatDate(_selectedEndDate!);
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Details'),
        actions: [
          TextButton(
            onPressed: () {
              var detail = DetailEntity(
                image: ref.read(detailViewModelProvider).image ?? '',
                tripName: _tripNameController.text,
                description: _descriptionController.text.trim(),
                startDate: _startDateController.text,
                endDate: _endDateController.text,
                user: UserEntity(
                  username: authState.user.isNotEmpty
                      ? authState.user[0].username
                      : '',
                  image: authState.imageName,
                  email: '',
                  password: '',
                  phone: '',
                ),
              );

              ref
                  .read(detailViewModelProvider.notifier)
                  .addDetails(context, detail);

              setState(() {
                _img = detail.image?.isNotEmpty == true
                    ? File(detail.image!)
                    : null;
              });
              Navigator.popAndPushNamed(context, AppRoute.homeRoute);
            },
            child: const Text(
              'Save',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      key: _saveKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40,
                          backgroundImage: _img != null
                              ? FileImage(_img!)
                              : const AssetImage('') as ImageProvider,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(
                                        ref,
                                        ImageSource.camera,
                                      );
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(
                                        ref,
                                        ImageSource.gallery,
                                      );
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Text('Change cover photo'),
                      ),
                    ],
                  ),
                ],
              ),
              gap,
              TextFormField(
                controller: _tripNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Trip Name',
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Trip Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.description,
                    color: Colors.orange,
                  ),
                  hintText: 'Description',
                ),
                minLines: 5,
                maxLines: 15,
              ),
              gap,
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Start date',
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.pink,
                  ),
                ),
                onTap: _selectStartDate, // Call the function when clicked
                readOnly: true,
                // Disable manual input
              ),
              gap,
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'End date',
                  icon: Icon(
                    Icons.event,
                    color: Colors.pink,
                  ),
                ),
                onTap: _selectEndDate, // Call the function when clicked
                readOnly: true, // Disable manual input
              ),
            ],
          ),
        ),
      ),
    );
  }
}
