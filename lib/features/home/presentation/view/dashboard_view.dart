import 'package:flutter/material.dart';
import 'package:travel_log/features/details/presentation/view/trip_view.dart';
import 'package:travel_log/features/home/presentation/view/map_view.dart';

import '../../../../config/router/app_route.dart';
import '../../../auth/presentation/view/profile_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedindex = 0;
  List<Widget> lstbscreen = [
    const TripView(),
    const MapView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstbscreen[_selectedindex],
      floatingActionButton: _selectedindex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.detailRoute);
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Material(
        elevation: 4.0,
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.red,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                label: 'Trip',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(icon: Icon(Icons.map_sharp), label: 'Map'),
            BottomNavigationBarItem(
                icon: Icon(Icons.face_sharp), label: 'Profile'),
          ],
          currentIndex: _selectedindex,
          onTap: (index) {
            setState(() {
              _selectedindex = index;
            });
          },
        ),
      ),
    );
  }
}
