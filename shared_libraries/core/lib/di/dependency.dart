import 'package:core/local/database/database_module.dart';
import 'package:core/network/dio_handler.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/get_it/get_it.dart';

class RegisterCoreModule {
  RegisterCoreModule() {
    _registerCore();
  }

  void _registerCore() {
    getInstance.registerLazySingleton<Dio>(() => getInstance<DioHandler>().dio);
    getInstance.registerLazySingleton<DioHandler>(() => DioHandler(
          sharedPreferences: getInstance(),
          apiBaseUrl: '',
        ));

    getInstance.registerLazySingleton<AppDatabase>(() => AppDatabase());
  }
}
