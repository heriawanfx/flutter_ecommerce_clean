import 'package:authentication/domain/entities/request/auth_request_entity.dart';
import 'package:authentication/domain/entities/response/auth_response_entity.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<FailureResponse, bool>> saveOnBoarding();

  Future<Either<FailureResponse, bool>> getOnBoardingStatus();

  Future<Either<FailureResponse, bool>> saveToken({required String token});

  Future<Either<FailureResponse, String>> getToken();

  Future<Either<FailureResponse, AuthResponseEntity>> signUp(
      {required AuthRequestEntity authRequestEntity});

  Future<Either<FailureResponse, AuthResponseEntity>> signIn(
      {required AuthRequestEntity authRequestEntity});

  Future<Either<FailureResponse, bool>> removeUserData();
}
