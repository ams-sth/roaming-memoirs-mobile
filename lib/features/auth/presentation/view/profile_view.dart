import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_log/config/constants/api_endpoint.dart';
import 'package:travel_log/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:travel_log/features/home/presentation/viewmodel/home_viewmodel.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authViewModelProvider.notifier).getUserProfile();
            },
            icon: const Icon(
              Icons.replay,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: authState.user.length,
          itemBuilder: (context, index) {
            var userDetail = authState.user[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(),
                  child: authState.user[index].image != null
                      ? Image.network(
                          ApiEndpoints.imageUrl + authState.user[index].image!,
                          fit: BoxFit.cover,
                        )
                      : const Center(child: Text("No Image")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userDetail.username,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userDetail.email,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            userDetail.phone,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
                // ButtonBar(
                //   alignment: MainAxisAlignment.end,
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         // Edit button pressed
                //       },
                //       icon: const Icon(
                //         Icons.edit,
                //         color: Colors.red,
                //       ),
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         // Delete button pressed
                //       },
                //       icon: const Icon(
                //         Icons.delete,
                //         color: Colors.red,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
