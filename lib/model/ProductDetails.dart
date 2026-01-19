import 'package:flutter_ecommerce/model/ProductVariant.dart';
import 'package:flutter_ecommerce/model/Reviews.dart';

class ProductDetails {
  final String id;
  final String name;
  final String description;
  final List<Review> reviews;
  final int rating;
  final String videoUrl;

  final String storeName;
  final String storeImageUrl;

  final String brand;
  final String category;
  final List<String> tags;

  final List<ProductVariant> variants;

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
    required this.reviews,
    required this.rating,
    required this.videoUrl,
    required this.storeName,
    required this.storeImageUrl,
    required this.brand,
    required this.category,
    required this.tags,
    required this.variants,
    required this.specifications,
    required this.features,
    required this.aboutTheProduct,
    required this.relatedProducts,
    required this.relatedProductsByCategory,
    required this.relatedProductsByBrand,
  });
}

final mockProductDetail = ProductDetails(
  id: 'p1',
  name: 'Sony WH-1000XM5 Premium Noise Canceling Headphones',
  description: 'Dive into an immersive audio experience with the Sony WH-1000XM5...',
  storeName: 'Tech World',
  storeImageUrl: 'https://cdn.freebiesupply.com/logos/large/2x/razer-logo-png-transparent.png',
  rating: 4,
  videoUrl: 'https://www.youtube.com/watch?v=example',
  brand: 'Sony',
  category: 'Electronics',
  tags: ['Wireless', 'Bluetooth', 'Audio', 'Premium'],

  variants: [
    ProductVariant(
      id: 'v1',
      color: 'Black',
      size: 'Standard',
      price: 348.00,
      oldPrice: 399.99,
      stock: 12,
      sku: 'SONY-XM5-BLK',
      imageUrls: [
        'https://m.media-amazon.com/images/I/61vJtKbAssL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/51gaT35OeML._SX522_.jpg',
        'https://m.media-amazon.com/images/I/51OGN-Nlu7L._SL1080_.jpg',
      ],
    ),
    ProductVariant(
      id: 'v2',
      color: 'Silver',
      size: 'Standard',
      price: 358.00,
      stock: 0,
      sku: 'SONY-XM5-SLV',
      imageUrls: [
        'https://m.media-amazon.com/images/I/61ULAZmt9NL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/81+4fB1ehJL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/81zk7HFkz7L._SX522_.jpg',
      ],
    ),
    ProductVariant(
      id: 'v3',
      color: 'Pink',
      size: 'Standard',
      price: 348.00,
      stock: 5,
      sku: 'SONY-XM5-BLU',
      imageUrls: [
        'https://m.media-amazon.com/images/I/51FvhumQETL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/81m6Pyx8ypL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/71uinJcxSzL._SL1500_.jpg',
      ],
    ),
  ],

  specifications: {'Battery Life': '30 Hours', 'Charging': 'USB-C', 'Bluetooth': 'v5.2', 'Weight': '250g'},

  features: ['Industry-leading noise cancellation', 'Magnificent Sound', 'Crystal clear hands-free calling'],

  aboutTheProduct: [
    'Two processors control 8 microphones for unprecedented noise cancellation.',
    'Auto NC Optimizer automatically optimizes noise cancellation.',
  ],

  reviews: [
    Review(
      userName: 'Alex Johnson',
      comment: 'Best headphones I have ever owned!',
      rating: 5,
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
