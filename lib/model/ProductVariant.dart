class ProductVariant {
  final String id;
  final String color;
  final String size;
  final double price;
  final double? oldPrice;
  final int stock;
  final List<String> imageUrls;
  final String sku;

  ProductVariant({
    required this.id,
    required this.color,
    required this.size,
    required this.price,
    this.oldPrice,
    required this.stock,
    required this.imageUrls,
    required this.sku,
  });

  double get discountPercentage {
    if (oldPrice == null || oldPrice! <= price) return 0;
    return ((oldPrice! - price) / oldPrice!) * 100;
  }
}
