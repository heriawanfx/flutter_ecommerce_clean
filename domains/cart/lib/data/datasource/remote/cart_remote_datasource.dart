import 'package:cart/data/model/request/add_to_cart_dto.dart';
import 'package:cart/data/model/response/cart_response_dto.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';

abstract class CartRemoteDataSource {
  const CartRemoteDataSource();

  Future<CartResponseDto> addToCart(AddToCartDto body);

  Future<CartResponseDto> getCarts();

  Future<CartResponseDto> deleteCart(AddToCartDto body);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio dio;

  const CartRemoteDataSourceImpl({required this.dio});

  @override
  Future<CartResponseDto> addToCart(AddToCartDto body) async {
    try {
      final formData = FormData.fromMap({
        body.productId: body.amount,
      });
      final response = await dio.post(
        "${AppConstants.appApi.baseUrl}${AppConstants.appApi.cart}",
        data: formData,
      );
      return CartResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartResponseDto> getCarts() async {
    try {
      final response = await dio.get(
        "${AppConstants.appApi.baseUrl}${AppConstants.appApi.cart}",
      );
      return CartResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartResponseDto> deleteCart(AddToCartDto body) async {
    try {
      final formData = FormData.fromMap({
        body.productId: body.amount,
      });
      final response = await dio.delete(
        "${AppConstants.appApi.baseUrl}${AppConstants.appApi.cart}",
        data: formData,
      );
      return CartResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
