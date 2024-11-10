// import 'package:dartz/dartz.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:travel_log/core/failure/failure.dart';
// import 'package:travel_log/features/auth/domain/entity/user_entity.dart';
// import 'package:travel_log/features/auth/domain/use_case/auth_usecase.dart';
// import 'package:travel_log/features/auth/presentation/viewmodel/auth_view_model.dart';

// import 'auth_unit_register_test.mocks.dart';

// @GenerateNiceMocks([
//   MockSpec<AuthUseCase>(),
//   MockSpec<BuildContext>(),
// ])
// void main() {
//   late AuthUseCase mockAuthUsecase;
//   late ProviderContainer container;
//   late BuildContext context;
//   late UserEntity user;

//   setUpAll(() {
//     mockAuthUsecase = MockAuthUseCase();
//     context = MockBuildContext();
//     container = ProviderContainer(
//       overrides: [
//         authViewModelProvider.overrideWith(
//           (ref) => AuthViewModel(mockAuthUsecase),
//         ),
//       ],
//     );
//   });

//   // For Signup
//   test('Test for initial state ', () async {
//     final authState = container.read(authViewModelProvider);
//     expect(authState.isLoading, false);
//   });
//   test('Valid signup test for the user', () async {
//     user = UserEntity(
//       phone: '98402194860',
//       username: 'amsh',
//       password: '1234',
//       email: 'amsh@gmail.com',
//     );
//     when(mockAuthUsecase.registerUser(user))
//         .thenAnswer((_) => Future.value(const Right(true)));
//     await container
//         .read(authViewModelProvider.notifier)
//         .registerUser(context, user);

//     final authState = container.read(authViewModelProvider);

//     expect(authState.error, isNull);
//   });

//   test('Invalid signup test for the user', () async {
//     user = const UserEntity(
//       phone: '9822202849',
//       username: 'amsh',
//       password: 'amsh123',
//       email: 'amsh37@gmail.com',
//     );

//     when(mockAuthUsecase.registerUser(user))
//         .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

//     await container
//         .read(authViewModelProvider.notifier)
//         .registerUser(context, user);
//     final authState = container.read(authViewModelProvider);
//     expect(authState.error, 'Invalid');
//   });
// }
