import 'package:cart/data/datasource/remote/cart_remote_datasource.dart';
import 'package:cart/data/mapper/cart_mapper.dart';
import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:cart/domain/repository/cart_repository.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  final CartMapper mapper;

  CartRepositoryImpl({
    required this.cartRemoteDataSource,
    required this.mapper,
  });

  @override
  Future<Either<FailureResponse, CartDataEntity>> addToCart(
      AddToCartEntity body) async {
    try {
      final response = await cartRemoteDataSource
          .addToCart(mapper.mapAddToCartEntityToDto(body));
      return Right(
        mapper.mapCartDataDtoToEntity(response.data),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, CartDataEntity>> getCarts() async {
    try {
      final response = await cartRemoteDataSource.getCarts();
      return Right(
        mapper.mapCartDataDtoToEntity(response.data),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, CartDataEntity>> deleteCart(
      AddToCartEntity body) async {
    try {
      final response = await cartRemoteDataSource
          .deleteCart(mapper.mapAddToCartEntityToDto(body));
      return Right(
        mapper.mapCartDataDtoToEntity(response.data),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }
}
