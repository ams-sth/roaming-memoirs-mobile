import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_log/config/constants/api_endpoint.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/detail_entity.dart';
import 'detail_view_model.dart';

class TripView extends ConsumerStatefulWidget {
  const TripView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TripViewState();
}

class _TripViewState extends ConsumerState<TripView> {
  void _onDeletePressed(DetailEntity tripDetail) {
    final viewModel = ref.read(detailViewModelProvider.notifier);
    viewModel.deleteDetails(context, tripDetail);
  }

  @override
  Widget build(BuildContext context) {
    var detailState = ref.watch(detailViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Feed'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(detailViewModelProvider.notifier).getAllDetails();
              showSnackBar(message: 'Refreshing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: detailState.details.length,
          reverse: true,
          itemBuilder: (context, index) {
            var tripDetail = detailState.details[index];
            var user = tripDetail.user;
            var userUsername = user.username;
            var userImage = user.image;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(),
                          child: ClipOval(
                            child: userImage != null
                                ? Image.network(
                                    ApiEndpoints.imageUrl + userImage,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          userUsername,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber),
                    ),
                    child: detailState.details[index].image != null
                        ? Image.network(
                            ApiEndpoints.imageUrl +
                                detailState.details[index].image!,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Text("No Image"),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tripDetail.tripName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          tripDetail.description ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'From',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              tripDetail.startDate,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'To',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              tripDetail.endDate,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          _onDeletePressed(tripDetail);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
