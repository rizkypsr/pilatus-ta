import 'package:dartz/dartz.dart';
import 'package:pilatus/common/failure.dart';
import 'package:pilatus/domain/entities/auth.dart';
import 'package:pilatus/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, Auth>> execute(String email, String password) {
    return repository.login(email, password);
  }
}
