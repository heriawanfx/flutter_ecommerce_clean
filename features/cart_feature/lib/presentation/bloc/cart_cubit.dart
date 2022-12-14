import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:cart/domain/usecases/delete_cart_usecase.dart';
import 'package:cart/domain/usecases/get_cart_usecase.dart';
import 'package:cart_feature/presentation/bloc/bloc.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.deleteCartUseCase,
  }) : super(CartState(
          cartListState: ViewData.initial(),
          addCartState: ViewData.initial(),
          deleteCartState: ViewData.initial(),
        ));

  void deleteProduct({
    required String productId,
    required int amount,
  }) async {
    emit(state.copyWith(deleteCartState: ViewData.loading(message: 'Loading')));

    final result = await deleteCartUseCase.call(AddToCartEntity(
      productId: productId,
      amount: amount,
    ));

    return result.fold(
      (failure) => _onFailureDeleteCart(failure),
      (data) => _onSuccessDeleteCart(data),
    );
  }

  Future<void> _onFailureDeleteCart(
    FailureResponse failure,
  ) async {
    emit(state.copyWith(
        deleteCartState:
            ViewData.error(message: failure.errorMessage, failure: failure)));
  }

  Future<void> _onSuccessDeleteCart(
    CartDataEntity data,
  ) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(
        deleteCartState: ViewData.noData(message: "No Data"),
        cartListState: ViewData.noData(message: "No Data"),
      ));
    } else {
      emit(state.copyWith(
        deleteCartState: ViewData.loaded(data: data),
        cartListState: ViewData.loaded(data: data),
      ));
    }
  }

  void addProduct({
    required String productId,
    required int amount,
  }) async {
    emit(state.copyWith(addCartState: ViewData.loading(message: 'Loading')));

    final result = await addToCartUseCase.call(AddToCartEntity(
      productId: productId,
      amount: amount,
    ));

    return result.fold(
      (failure) => _onFailureAddCart(failure),
      (data) => _onSuccessAddCart(data),
    );
  }

  Future<void> _onFailureAddCart(
    FailureResponse failure,
  ) async {
    emit(state.copyWith(
        addCartState:
            ViewData.error(message: failure.errorMessage, failure: failure)));
  }

  Future<void> _onSuccessAddCart(
    CartDataEntity data,
  ) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(
        addCartState: ViewData.noData(message: "No Data"),
        cartListState: ViewData.noData(message: "No Data"),
      ));
    } else {
      emit(state.copyWith(
        addCartState: ViewData.loaded(data: data),
        cartListState: ViewData.loaded(data: data),
      ));
    }
  }

  void selectAll(bool selected) {
    int totalAmount = 0;
    final selectProducts = state.selectProducts;
    final newSelectProducts = <bool>[];
    final data = state.cartListState.data;

    if (selected) {
      final products = data?.product ?? [];

      for (var i in products) {
        if (i.quantity < 0) {
          totalAmount += 0;
        } else {
          totalAmount += (i.product.price * i.quantity);
        }
      }

      for (var i in selectProducts) {
        debugPrint("Set to True: $i");
        newSelectProducts.add(true);
      }

      emit(state.copyWith(
        selectAll: selected,
        totalAmount: totalAmount,
        selectProducts: newSelectProducts,
        cartListState: ViewData.loaded(data: data),
      ));
    } else {
      totalAmount = 0;

      for (var i in selectProducts) {
        debugPrint("Set to False: $i");
        newSelectProducts.add(false);
      }

      emit(state.copyWith(
        selectAll: selected,
        totalAmount: totalAmount,
        selectProducts: newSelectProducts,
        cartListState: ViewData.loaded(data: data),
      ));
    }
  }

  void selectProduct(bool selected, int index) {
    final selectProducts = state.selectProducts;
    final newSelectProducts = <bool>[];
    final data = state.cartListState.data;
    var totalAmount = state.totalAmount;
    var selectAll = false;

    final products = data?.product ?? [];
    final selectedAmount = products[index].product.price;
    newSelectProducts.addAll(selectProducts);
    if (selected) {
      final total = totalAmount + selectedAmount;
      totalAmount = total;
      newSelectProducts[index] = true;
    } else {
      final total = totalAmount - selectedAmount;
      totalAmount = total;
      newSelectProducts[index] = false;
    }

    for (var i in newSelectProducts) {
      if (i) {
        selectAll = true;
      } else {
        selectAll = false;
        break;
      }
    }

    emit(state.copyWith(
      selectAll: selectAll,
      totalAmount: totalAmount,
      selectProducts: newSelectProducts,
      cartListState: ViewData.loaded(data: data),
    ));
  }

  void getCart() async {
    emit(state.copyWith(cartListState: ViewData.loading(message: 'Loading')));

    final result = await getCartUseCase.call(const NoParams());
    return result.fold(
      (failure) => _onFailureGetCart(failure),
      (data) => _onSuccessGetCart(data),
    );
  }

  Future<void> _onFailureGetCart(
    FailureResponse failure,
  ) async {
    emit(state.copyWith(
        cartListState:
            ViewData.error(message: failure.errorMessage, failure: failure)));
  }

  Future<void> _onSuccessGetCart(
    CartDataEntity data,
  ) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(cartListState: ViewData.noData(message: "No Data")));
    } else {
      final selectProducts = <bool>[];
      for (var i in data.product) {
        debugPrint("Product Name: ${i.product.name}");
        selectProducts.add(false);
      }
      emit(state.copyWith(
        cartListState: ViewData.loaded(data: data),
        selectAll: false,
        selectProducts: selectProducts,
        totalAmount: 0,
      ));
    }
  }
}
