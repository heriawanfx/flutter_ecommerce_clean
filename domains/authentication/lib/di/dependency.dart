import 'package:authentication/data/datasource/local/authentication_local_datasource.dart';
import 'package:authentication/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:authentication/data/mapper/authentication_mapper.dart';
import 'package:authentication/data/repository/authentication_repository_impl.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:authentication/domain/usecases/save_onboarding_usecase.dart';
import 'package:authentication/domain/usecases/save_token_usecase.dart';
import 'package:authentication/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:authentication/domain/usecases/get_token_usecase.dart';
import 'package:authentication/domain/usecases/logout_usecase.dart';
import 'package:authentication/domain/usecases/sign_in_usecase.dart';
import 'package:authentication/domain/usecases/sign_up_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';

class AuthenticationDependency {
  AuthenticationDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSources() {
    getInstance.registerLazySingleton<AuthenticationLocalDataSources>(
      () => AuthenticationLocalDataSourcesImpl(
        sharedPreferences: getInstance(),
      ),
    );

    getInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(
        dio: getInstance(),
      ),
    );
  }

  void _registerMapper() =>
      getInstance.registerLazySingleton<AuthenticationMapper>(
        () => AuthenticationMapper(),
      );

  void _registerRepository() =>
      getInstance.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(
          authenticationLocalDataSources: getInstance(),
          authenticationRemoteDataSource: getInstance(),
          mapper: getInstance(),
        ),
      );

  void _registerUseCases() {
    getInstance.registerLazySingleton<GetOnBoardingStatusUseCase>(
      () => GetOnBoardingStatusUseCase(
        authenticationRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<SaveOnBoardingUseCase>(
      () => SaveOnBoardingUseCase(
        authenticationRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<SaveTokenUseCase>(
      () => SaveTokenUseCase(
        authenticationRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<GetTokenUseCase>(
      () => GetTokenUseCase(
        authenticationRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(
        authenticationRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(
        authenticationRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        authenticationRepository: getInstance(),
      ),
    );
  }
}
