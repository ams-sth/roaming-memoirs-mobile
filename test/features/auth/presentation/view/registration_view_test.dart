import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:travel_log/config/router/app_route.dart';
import 'package:travel_log/features/auth/domain/entity/user_entity.dart';
import 'package:travel_log/features/auth/domain/use_case/auth_usecase.dart';
import 'package:travel_log/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'registration_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late UserEntity userEntity;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();

    userEntity = UserEntity(
      id: '',
      image: null,
      phone: '9840284922',
      email: 'amshstha37@gmail.com',
      username: 'amshstha',
      password: 'amsh1234',
    );
  });

  testWidgets('register view ...', (tester) async {
    when(mockAuthUsecase.registerUser(userEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextFormField).at(0), 'amshstha37@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '9840284922');
    await tester.enterText(find.byType(TextFormField).at(2), 'amshstha');
    await tester.enterText(find.byType(TextFormField).at(3), 'amsh1234');

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Create my account');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);
  });
}
