import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:common/utils/state/view_data_state.dart';

class CartState {
  final ViewData<CartDataEntity> cartListState;
  final ViewData<CartDataEntity> addCartState;
  final ViewData<CartDataEntity> deleteCartState;
  final int totalAmount;
  final bool selectAll;
  final List<bool> selectProducts;

  const CartState({
    required this.cartListState,
    required this.addCartState,
    required this.deleteCartState,
    this.totalAmount = 0,
    this.selectAll = false,
    this.selectProducts = const <bool>[],
  });

  CartState copyWith({
    ViewData<CartDataEntity>? cartListState,
    ViewData<CartDataEntity>? addCartState,
    ViewData<CartDataEntity>? deleteCartState,
    int? totalAmount,
    bool? selectAll,
    List<bool>? selectProducts,
  }) {
    return CartState(
      cartListState: cartListState ?? this.cartListState,
      addCartState: addCartState ?? this.addCartState,
      deleteCartState: deleteCartState ?? this.deleteCartState,
      totalAmount: totalAmount ?? this.totalAmount,
      selectAll: selectAll ?? this.selectAll,
      selectProducts: selectProducts ?? this.selectProducts,
    );
  }
}
