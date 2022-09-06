import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:cart/domain/repository/cart_repository.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

class GetCartUseCase extends UseCase<CartDataEntity, NoParams> {
  final CartRepository cartRepository;

  GetCartUseCase({
    required this.cartRepository,
  });

  @override
  Future<Either<FailureResponse, CartDataEntity>> call(
          NoParams params) async =>
      await cartRepository.getCarts();
}
