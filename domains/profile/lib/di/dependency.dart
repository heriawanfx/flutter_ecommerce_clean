import 'package:dependencies/get_it/get_it.dart';
import 'package:profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:profile/data/mapper/profile_mapper.dart';
import 'package:profile/data/repository/profile_repository_impl.dart';
import 'package:profile/domain/repository/profile_repository.dart';
import 'package:profile/domain/usecases/get_user_usecase.dart';
import 'package:profile/domain/usecases/update_user_usecase.dart';
import 'package:profile/domain/usecases/upload_photo_usecase.dart';

class ProfileDependency {
  ProfileDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSources() {
    getInstance.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
        dio: getInstance(),
      ),
    );
  }

  void _registerMapper() => getInstance.registerLazySingleton<ProfileMapper>(
        () => ProfileMapper(),
      );

  void _registerRepository() => getInstance.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
          profileRemoteDataSource: getInstance(),
          mapper: getInstance(),
        ),
      );

  void _registerUseCases() {
    getInstance.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(
        profileRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<UpdateUserUseCase>(
          () => UpdateUserUseCase(
        profileRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<UploadPhotoUseCase>(
          () => UploadPhotoUseCase(
        profileRepository: getInstance(),
      ),
    );
  }
}
