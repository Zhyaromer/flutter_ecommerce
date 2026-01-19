import 'package:flutter_ecommerce/model/Reviews.dart';

class ProductDetails {
  final String id;
  final String name;
  final String description;
  final List<String> imageUrls;
  final double price;
  final double? oldPrice;
  final List<Review> reviews;
  final double rating;
  final String videoUrl;

  final String brand;
  final String category;
  final List<String> tags;

  final List<String> colorsAvailable;
  final List<String> sizesAvailable;

  final Map<String, String> specifications;
  final List<String> features;
  final List<String> aboutTheProduct;

  final List<String> relatedProducts;
  final List<String> relatedProductsByCategory;
  final List<String> relatedProductsByBrand;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.price,
    this.oldPrice,
    required this.reviews,
    required this.rating,
    required this.brand,
    required this.category,
    required this.tags,
    required this.colorsAvailable,
    required this.sizesAvailable,
    required this.specifications,
    required this.features,
    required this.aboutTheProduct,
    required this.relatedProducts,
    required this.relatedProductsByCategory,
    required this.relatedProductsByBrand,
    required this.videoUrl,
  });

  // Recommended: Add a getter for discount percentage
  double get discountPercentage {
    if (oldPrice == null || oldPrice! <= price) return 0;
    return ((oldPrice! - price) / oldPrice!) * 100;
  }
}

final mockProductDetail = ProductDetails(
  id: 'p1',
  name: 'Sony WH-1000XM5 Noise Canceling Headphones',
  description: 'The Sony WH-1000XM5 headphones rewrite the rules for distraction-free listening.',
  price: 348.00,
  oldPrice: 399.99,
  imageUrls: [
    'https://m.media-amazon.com/images/I/61vjK2qQz9L._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/6127n96aVBL._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/517fS8v364L._AC_SL1500_.jpg',
  ],
  rating: 4.8,
  videoUrl: 'https://www.youtube.com/watch?v=example',
  brand: 'Sony',
  category: 'Electronics',
  tags: ['Wireless', 'Bluetooth', 'Audio', 'Premium'],
  colorsAvailable: ['Midnight Blue', 'Silver', 'Black'],
  sizesAvailable: ['Standard'],
  specifications: {'Battery Life': '30 Hours', 'Charging': 'USB-C', 'Bluetooth': 'v5.2', 'Weight': '250g'},
  features: ['Industry-leading noise cancellation', 'Magnificent Sound', 'Crystal clear hands-free calling'],
  aboutTheProduct: [
    'Two processors control 8 microphones for unprecedented noise cancellation.',
    'Auto NC Optimizer automatically optimizes noise cancellation based on wearing conditions.',
  ],
  reviews: [
    Review(
      userName: 'Alex Johnson',
      comment: 'Best headphones I have ever owned! The silence is magical.',
      rating: 5.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '1',
      productId: 'p1',
      userId: 'u1',
    ),
  ],
  relatedProducts: ['p2', 'p3'],
  relatedProductsByCategory: ['p10', 'p11'],
  relatedProductsByBrand: ['p5', 'p6'],
);
