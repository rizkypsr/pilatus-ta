import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
}
