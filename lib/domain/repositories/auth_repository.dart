import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> login(String email, String password);
  Future<Either<Failure, Auth>> register(
      String name, String email, String password);
  Future<Either<Failure, bool>> logout();
}
