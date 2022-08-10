import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/auth.dart';
import 'package:pilatus/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<Either<Failure, Auth>> execute(
      String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
