import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_log/features/home/presentation/view/dashboard_view.dart';
import 'package:travel_log/features/details/presentation/view/trip_view.dart';

void main() {
  testWidgets('DashboardView widget test', (tester) async {
    // Build the DashboardView widget
    await tester.pumpWidget(
      const MaterialApp(
        home: DashboardView(),
      ),
    );

    // Verify that the initial screen is TripView
    expect(find.byType(TripView), findsOneWidget);

    // Tap on the Trip bottom navigation bar item
    await tester.tap(find.byIcon(Icons.explore));
    await tester.pump();
  });
}
