import 'cart_model.dart';

class CartItemModel {
  final int id;
  final int productId;
  final CartProductModel product;
  final int quantity;
  final double subtotal;

  const CartItemModel({
    required this.id,
    required this.productId,
    required this.product,
    required this.quantity,
    required this.subtotal,
  });

  // Compatibility Getter
  String get productName => product.name;

  double get price => product.price;

  String? get imageUrl => product.imageUrl;

  double get totalPrice => subtotal;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = CartProductModel.fromJson(
      json['product'] as Map<String, dynamic>? ?? {},
    );

    final quantity = json['quantity'] as int? ?? 0;

    final apiSubtotal = (json['subtotal'] as num?)?.toDouble() ?? 0.0;

    final subtotal = apiSubtotal > 0 ? apiSubtotal : product.price * quantity;

    return CartItemModel(
      id: json['ID'] as int? ?? json['id'] as int? ?? 0,
      productId: json['product_id'] as int? ?? 0,
      product: product,
      quantity: quantity,
      subtotal: subtotal,
    );
  }

  CartItemModel copyWith({
    int? id,
    int? productId,
    CartProductModel? product,
    int? quantity,
    double? subtotal,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
    );
  }
}
