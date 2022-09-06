class CartResponseDto {
  CartResponseDto({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  final bool? status;
  final int? code;
  final String? message;
  final CartDataDto data;

  factory CartResponseDto.fromJson(Map<String, dynamic> json) =>
      CartResponseDto(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: CartDataDto.fromJson(json["data"]),
      );
}

class CartDataDto {
  CartDataDto({
    required this.id,
    required this.owner,
    required this.amount,
    required this.product,
  });

  final String? id;
  final String? owner;
  final int? amount;
  final List<ProductsCartDto> product;

  factory CartDataDto.fromJson(Map<String, dynamic> json) => CartDataDto(
        id: json["id"],
        owner: json["owner"],
        amount: json["amount"],
        product: List<ProductsCartDto>.from(
            json["product"].map((x) => ProductsCartDto.fromJson(x))),
      );
}

class ProductsCartDto {
  ProductsCartDto({
    required this.product,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  final ProductCartDto product;
  final int? quantity;
  final String? createdAt;
  final String? updatedAt;

  factory ProductsCartDto.fromJson(Map<String, dynamic> json) =>
      ProductsCartDto(
        product: ProductCartDto.fromJson(json["product"]),
        quantity: json["quantity"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class ProductCartDto {
  ProductCartDto({
    required this.id,
    required this.name,
    required this.owner,
    required this.stock,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.userInfo,
    required this.soldCount,
    required this.popularity,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? owner;
  final int? stock;
  final int? price;
  final CategoryCartDto category;
  final String? imageUrl;
  final String? description;
  final UserInfoCartDto userInfo;
  final int? soldCount;
  final double? popularity;
  final String? createdAt;
  final String? updatedAt;

  factory ProductCartDto.fromJson(Map<String, dynamic> json) =>
      ProductCartDto(
        id: json["id"],
        name: json["name"],
        owner: json["owner"],
        stock: json["stock"],
        price: json["price"],
        category: CategoryCartDto.fromJson(json["category"]),
        imageUrl: json["image_url"],
        description: json["description"],
        userInfo: UserInfoCartDto.fromJson(json["user_info"]),
        soldCount: json["sold_count"],
        popularity: json["popularity"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class CategoryCartDto {
  CategoryCartDto({
    required this.id,
    required this.name,
    required this.imageCover,
    required this.imageIcon,
  });

  final String? id;
  final String? name;
  final String? imageCover;
  final String? imageIcon;

  factory CategoryCartDto.fromJson(Map<String, dynamic> json) =>
      CategoryCartDto(
        id: json["id"],
        name: json["name"],
        imageCover: json["image_cover"],
        imageIcon: json["image_icon"],
      );
}

class UserInfoCartDto {
  UserInfoCartDto({
    required this.id,
    required this.name,
    required this.city,
  });

  final String? id;
  final String? name;
  final String? city;

  factory UserInfoCartDto.fromJson(Map<String, dynamic> json) =>
      UserInfoCartDto(
        id: json["id"],
        name: json["name"],
        city: json["city"],
      );
}
