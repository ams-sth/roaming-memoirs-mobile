import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_remote_repository.dart';
import '../entity/user_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.watch(authRemoteRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, List<UserEntity>>> getUserProfile();
}
