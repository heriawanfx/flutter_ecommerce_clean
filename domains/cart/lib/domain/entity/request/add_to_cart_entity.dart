import 'package:dependencies/equatable/equatable.dart';

class AddToCartEntity extends Equatable {
  final String productId;
  final int amount;
  final String productName;
  final String description;
  final String imageUrl;

  const AddToCartEntity({
    required this.productId,
    required this.amount,
    this.productName = "",
    this.description = "",
    this.imageUrl = "",
  });

  @override
  List<Object?> get props => [
        productId,
        amount,
        productName,
        description,
        imageUrl,
      ];
}
