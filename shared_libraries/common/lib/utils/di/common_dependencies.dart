import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/auth_router.dart';
import 'package:common/utils/navigation/router/cart_router.dart';
import 'package:common/utils/navigation/router/home_router.dart';
import 'package:common/utils/navigation/router/onboarding_router.dart';
import 'package:common/utils/navigation/router/payment_router.dart';
import 'package:common/utils/navigation/router/product_router.dart';
import 'package:dependencies/get_it/get_it.dart';

class CommonDependencies {
  CommonDependencies() {
    _navigation();
    _routers();
  }

  void _navigation() => getInstance.registerLazySingleton<NavigationHelper>(
        () => NavigationHelperImpl(),
      );

  void _routers() {
    getInstance.registerLazySingleton<OnboardingRouter>(
      () => OnboardingRouterImpl(
        navigationHelper: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<AuthRouter>(
      () => AuthRouterImpl(
        navigationHelper: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<HomeRouter>(
      () => HomeRouterImpl(
        navigationHelper: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<ProductRouter>(
      () => ProductRouterImpl(
        navigationHelper: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<CartRouter>(
          () => CartRouterImpl(
        navigationHelper: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<PaymentRouter>(
          () => PaymentRouterImpl(
        navigationHelper: getInstance(),
      ),
    );
  }
}
