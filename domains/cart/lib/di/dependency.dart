import 'package:cart/data/datasource/remote/cart_remote_datasource.dart';
import 'package:cart/data/mapper/cart_mapper.dart';
import 'package:cart/data/repository/cart_repository_impl.dart';
import 'package:cart/domain/repository/cart_repository.dart';
import 'package:cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:cart/domain/usecases/delete_cart_usecase.dart';
import 'package:cart/domain/usecases/get_cart_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';

class CartDependency {
  CartDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSources() {
    getInstance.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(
        dio: getInstance(),
      ),
    );
  }

  void _registerMapper() => getInstance.registerLazySingleton<CartMapper>(
        () => CartMapper(),
      );

  void _registerRepository() => getInstance.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(
          cartRemoteDataSource: getInstance(),
          mapper: getInstance(),
        ),
      );

  void _registerUseCases() {
    getInstance.registerLazySingleton<AddToCartUseCase>(
          () => AddToCartUseCase(
        cartRepository: getInstance(),
      ),
    );

    getInstance.registerLazySingleton<GetCartUseCase>(
          () => GetCartUseCase(
        cartRepository: getInstance(),
      ),
    );

    getInstance.registerLazySingleton<DeleteCartUseCase>(
          () => DeleteCartUseCase(
        cartRepository: getInstance(),
      ),
    );
  }
}
