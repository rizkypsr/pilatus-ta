import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/user.dart';
import 'package:pilatus/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<Either<Failure, User>> execute() {
    return repository.getUser();
  }
}
