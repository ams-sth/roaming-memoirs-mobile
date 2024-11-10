import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:travel_log/config/router/app_route.dart';
import 'package:travel_log/features/auth/domain/use_case/auth_usecase.dart';
import 'package:travel_log/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late AuthUseCase mockAuthUseCase;

  late bool isLogin;

  setUpAll(() async {
    mockAuthUseCase = MockAuthUseCase();

    isLogin = true;
  });

  testWidgets('Login test with username and password', (tester) async {
    when(mockAuthUseCase.loginUser('amsh', 'amsh123'))
        .thenAnswer((_) => Future.value(Right(isLogin)));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUseCase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'amsh');
    await tester.enterText(find.byType(TextFormField).at(1), 'amsh123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Trip'), findsOneWidget);
  });
}
