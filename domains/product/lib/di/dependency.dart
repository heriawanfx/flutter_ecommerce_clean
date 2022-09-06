import 'package:dependencies/get_it/get_it.dart';
import 'package:product/data/datasource/local/product_local_datasource.dart';
import 'package:product/data/datasource/remote/product_remote_datasource.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecases/delete_product_usecase.dart';
import 'package:product/domain/usecases/get_banner_usecase.dart';
import 'package:product/domain/usecases/get_favorite_product_by_url_usecase.dart';
import 'package:product/domain/usecases/get_product_category_usecase.dart';
import 'package:product/domain/usecases/get_product_detail_usecase.dart';
import 'package:product/domain/usecases/get_product_usecase.dart';
import 'package:product/domain/usecases/get_seller_usecase.dart';
import 'package:product/domain/usecases/save_product_usecase.dart';

class ProductDependency {
  ProductDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSources() {
    getInstance.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
        dio: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(
        appDatabase: getInstance(),
      ),
    );
  }

  void _registerMapper() => getInstance.registerLazySingleton<ProductMapper>(
        () => ProductMapper(),
      );

  void _registerRepository() => getInstance.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
          productRemoteDataSource: getInstance(),
          productLocalDataSource: getInstance(),
          mapper: getInstance(),
        ),
      );

  void _registerUseCases() {
    getInstance.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(
        productRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<GetProductCategoryUseCase>(
      () => GetProductCategoryUseCase(
        productRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<GetBannerUseCase>(
      () => GetBannerUseCase(
        productRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(
        productRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<GetSellerUseCase>(
      () => GetSellerUseCase(
        productRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<SaveProductUseCase>(
      () => SaveProductUseCase(
        productRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(
        productRepository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<GetFavoriteProductByUrlUseCase>(
      () => GetFavoriteProductByUrlUseCase(
        productRepository: getInstance(),
      ),
    );
  }
}
