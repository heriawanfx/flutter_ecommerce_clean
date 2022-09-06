import 'package:dependencies/equatable/equatable.dart';

class CartDataEntity extends Equatable {
  const CartDataEntity({
    this.id = "",
    this.owner = "",
    this.amount = 0,
    this.product = const <ProductsCartEntity>[],
  });

  final String id;
  final String owner;
  final int amount;
  final List<ProductsCartEntity> product;

  @override
  List<Object?> get props => [id, owner, amount, product];
}

class ProductsCartEntity extends Equatable {
  const ProductsCartEntity({
    this.product = const ProductCartEntity(),
    this.quantity = 0,
    this.createdAt = "",
    this.updatedAt = "",
  });

  final ProductCartEntity product;
  final int quantity;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object?> get props => [product, quantity, createdAt, updatedAt];
}

class ProductCartEntity extends Equatable {
  const ProductCartEntity({
    this.id = "",
    this.name = "",
    this.owner = "",
    this.stock = 0,
    this.price = 0,
    this.category = const CategoryCartEntity(),
    this.imageUrl = "",
    this.description = "",
    this.userInfo = const UserInfoCartEntity(),
    this.soldCount = 0,
    this.popularity = 0.0,
    this.createdAt = "",
    this.updatedAt = "",
  });

  final String id;
  final String name;
  final String owner;
  final int stock;
  final int price;
  final CategoryCartEntity category;
  final String imageUrl;
  final String description;
  final UserInfoCartEntity userInfo;
  final int soldCount;
  final double popularity;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        owner,
        stock,
        price,
        category,
        imageUrl,
        description,
        userInfo,
        soldCount,
        popularity,
        createdAt,
        updatedAt,
      ];
}

class CategoryCartEntity extends Equatable {
  const CategoryCartEntity({
    this.id = "",
    this.name = "",
    this.imageCover = "",
    this.imageIcon = "",
  });

  final String id;
  final String name;
  final String imageCover;
  final String imageIcon;

  @override
  List<Object?> get props => [id, name, imageCover, imageIcon];
}

class UserInfoCartEntity extends Equatable {
  const UserInfoCartEntity({
    this.id = "",
    this.name = "",
    this.city = "",
  });

  final String id;
  final String name;
  final String city;

  @override
  List<Object?> get props => [id, name, city];
}
