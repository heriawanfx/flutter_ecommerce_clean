import 'package:dependencies/get_it/get_it.dart';
import 'package:payment/data/datasource/remote/payment_remote_datasource.dart';
import 'package:payment/data/mapper/payment_mapper.dart';
import 'package:payment/data/repository/payment_repository_impl.dart';
import 'package:payment/domain/repository/payment_repository.dart';
import 'package:payment/domain/usecases/create_transaction_usecase.dart';
import 'package:payment/domain/usecases/get_all_payment_method_usecase.dart';
import 'package:payment/domain/usecases/get_history_usecase.dart';

class PaymentDependency {
  PaymentDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSources() {
    getInstance.registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceImpl(
        dio: getInstance(),
      ),
    );
  }

  void _registerMapper() => getInstance.registerLazySingleton<PaymentMapper>(
        () => PaymentMapper(),
      );

  void _registerRepository() => getInstance.registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(
          remoteDataSource: getInstance(),
          mapper: getInstance(),
        ),
      );

  void _registerUseCases() {
    getInstance.registerLazySingleton<GetAllPaymentMethodUseCase>(
      () => GetAllPaymentMethodUseCase(
        repository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<CreateTransactionUseCase>(
      () => CreateTransactionUseCase(
        repository: getInstance(),
      ),
    );
    getInstance.registerLazySingleton<GetHistoryUseCase>(
      () => GetHistoryUseCase(
        repository: getInstance(),
      ),
    );
  }
}
