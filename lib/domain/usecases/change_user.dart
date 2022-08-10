import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/user.dart';
import 'package:pilatus/domain/repositories/user_repository.dart';

class ChangeUser {
  final UserRepository repository;

  ChangeUser(this.repository);

  Future<Either<Failure, User>> execute(String name) {
    return repository.changeUser(name);
  }
}
