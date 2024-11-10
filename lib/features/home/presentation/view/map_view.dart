import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  final _mapController = MapController.withUserPosition(
      trackUserLocation:
          const UserTrackingOption(enableTracking: true, unFollowUser: false));
  var markerMap = <String, String>{};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mapController.listenerMapSingleTapping.addListener(
        () {
          var position = _mapController.listenerMapSingleTapping.value;
          if (position != null) {
            _mapController.addMarker(
              position,
              markerIcon: const MarkerIcon(
                icon: Icon(Icons.pin_drop, color: Colors.blue, size: 48),
              ),
            );
            var key = '${position.latitude}_${position.longitude}';
            markerMap[key] = markerMap.length.toString();
          }
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OSMFlutter(
        controller: _mapController,
        mapIsLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        initZoom: 12,
        minZoomLevel: 4,
        maxZoomLevel: 14,
        stepZoom: 1.0,
        userTrackingOption:
            const UserTrackingOption(enableTracking: true, unFollowUser: false),
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.personal_injury,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: const RoadOption(roadColor: Colors.blueGrey),
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.black,
              size: 48,
            ),
          ),
        ),
        onMapIsReady: (isReady) async {
          if (isReady) {
            await Future.delayed(const Duration(seconds: 1), () async {
              await _mapController.currentLocation();
            });
          }
        },
      ),
    );
  }
}
