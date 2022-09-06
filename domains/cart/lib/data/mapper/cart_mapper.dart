import 'package:cart/data/model/request/add_to_cart_dto.dart';
import 'package:cart/data/model/response/cart_response_dto.dart';
import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:cart/domain/entity/response/cart_entity.dart';

class CartMapper {
  UserInfoCartEntity mapUserInfoCartDtoToEntity(UserInfoCartDto dto) {
    return UserInfoCartEntity(
      id: dto.id ?? "",
      name: dto.name ?? "",
      city: dto.city ?? "",
    );
  }

  CategoryCartEntity mapCategoryCartDtoToEntity(CategoryCartDto dto) {
    return CategoryCartEntity(
      id: dto.id ?? "",
      name: dto.name ?? "",
      imageIcon: dto.imageIcon ?? "",
      imageCover: dto.imageCover ?? "",
    );
  }

  ProductCartEntity mapProductCartDtoToEntity(ProductCartDto dto) {
    return ProductCartEntity(
      id: dto.id ?? "",
      name: dto.name ?? "",
      owner: dto.owner ?? "",
      stock: dto.stock ?? 0,
      price: dto.price ?? 0,
      category: mapCategoryCartDtoToEntity(dto.category),
      imageUrl: dto.imageUrl ?? "",
      description: dto.description ?? "",
      userInfo: mapUserInfoCartDtoToEntity(dto.userInfo),
      soldCount: dto.soldCount ?? 0,
      popularity: dto.popularity ?? 0.0,
      createdAt: dto.createdAt ?? "",
      updatedAt: dto.updatedAt ?? "",
    );
  }

  ProductsCartEntity mapProductsCartDtoToEntity(ProductsCartDto dto) {
    return ProductsCartEntity(
      product: mapProductCartDtoToEntity(dto.product),
      quantity: dto.quantity ?? 0,
      createdAt: dto.createdAt ?? "",
      updatedAt: dto.updatedAt ?? "",
    );
  }

  List<ProductsCartEntity> mapListProductsCartDtoToEntity(
      List<ProductsCartDto> dto) {
    final products = <ProductsCartEntity>[];
    for (ProductsCartDto i in dto) {
      final qty = i.quantity ?? 0;
      if (qty > 0) {
        products.add(mapProductsCartDtoToEntity(i));
      }
    }
    return products;
  }

  CartDataEntity mapCartDataDtoToEntity(CartDataDto dto) {
    return CartDataEntity(
      id: dto.id ?? "",
      owner: dto.owner ?? "",
      amount: dto.amount ?? 0,
      product: mapListProductsCartDtoToEntity(dto.product),
    );
  }

  AddToCartDto mapAddToCartEntityToDto(AddToCartEntity entity) {
    return AddToCartDto(
      productId: entity.productId,
      amount: entity.amount,
    );
  }
}
