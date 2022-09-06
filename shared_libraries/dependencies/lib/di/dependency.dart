import 'package:dependencies/firebase/firebase.dart';
import 'package:dependencies/image_picker/image_picker.dart';

import '../get_it/get_it.dart';
import '../shared_preferences/shared_preferences.dart';

class SharedLibDependencies {
  const SharedLibDependencies();

  Future<void> registerCore() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    getInstance.registerLazySingleton(() => sharedPreferences);
    getInstance.registerLazySingleton<FirebaseMessaging>(
        () => FirebaseMessaging.instance);
    getInstance.registerLazySingleton<ImagePicker>(() => ImagePicker());
  }
}
