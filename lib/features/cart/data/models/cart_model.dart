class CartProductModel {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  const CartProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        id: json['ID'] as int? ?? json['id'] as int? ?? 0,
        name: json['name'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        imageUrl: json['image_url'] as String? ?? '',
        category: json['category'] as String? ?? '',
      );
}

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

  // ==========================
  // Compatibility Getter
  // Agar cocok dengan CheckoutPage Pasar Malam
  // ==========================

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
}
