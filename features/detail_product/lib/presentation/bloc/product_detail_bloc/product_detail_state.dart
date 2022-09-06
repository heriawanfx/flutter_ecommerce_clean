import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';

class ProductDetailState {
  final ViewData<ProductDetailDataEntity> productState;
  final ViewData<SellerDataEntity> sellerState;
  final ViewData<AddToCartEntity> addToCartState;
  final ViewData<bool> saveProductState;
  final ViewData<bool> deleteProductState;
  final bool isFavorite;

  const ProductDetailState({
    required this.productState,
    required this.sellerState,
    required this.addToCartState,
    required this.saveProductState,
    required this.deleteProductState,
    this.isFavorite = false,
  });

  ProductDetailState copyWith({
    ViewData<ProductDetailDataEntity>? productState,
    ViewData<SellerDataEntity>? sellerState,
    ViewData<AddToCartEntity>? addToCartState,
    ViewData<bool>? saveProductState,
    ViewData<bool>? deleteProductState,
    bool? isFavorite,
  }) {
    return ProductDetailState(
      productState: productState ?? this.productState,
      sellerState: sellerState ?? this.sellerState,
      addToCartState: addToCartState ?? this.addToCartState,
      saveProductState: saveProductState ?? this.saveProductState,
      deleteProductState: deleteProductState ?? this.deleteProductState,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
