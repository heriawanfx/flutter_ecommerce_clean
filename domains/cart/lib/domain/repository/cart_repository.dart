import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';

abstract class CartRepository {
  const CartRepository();

  Future<Either<FailureResponse, CartDataEntity>> addToCart(
      AddToCartEntity body);

  Future<Either<FailureResponse, CartDataEntity>> getCarts();

  Future<Either<FailureResponse, CartDataEntity>> deleteCart(
      AddToCartEntity body);
}
