import 'package:flutter_ecommerce/model/ProductVariant.dart';
import 'package:flutter_ecommerce/model/Reviews.dart';

class ProductDetails {
  final String id; //done
  final String name; //done
  final String description; // done
  final List<Review> reviews;
  final int rating; //done

  final String storeName; //done
  final String storeImageUrl; //done

  final String brand; //done
  final String category; //done

  final List<ProductVariant> variants; //done

  final Map<String, String> specifications; // done
  final List<String> features; // done
  final List<String> aboutTheProduct; // done

  final List<String> relatedProducts;
  final List<String> relatedProductsByCategory;
  final List<String> relatedProductsByBrand;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.reviews,
    required this.rating,
    required this.storeName,
    required this.storeImageUrl,
    required this.brand,
    required this.category,
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
  description:
      'The WH-1000XM5 headphones rewrite the rules for distraction-free listening. The WH1000XM5 has two processors that control 8 microphones for unprecedented noise cancellation and exceptional call quality. With a newly developed driver, DSEE – Extreme and Hires audio support the WH-1000XM5 headphones provide awe-inspiring audio quality.',
  storeName: 'Tech World',
  storeImageUrl: 'https://cdn.freebiesupply.com/logos/large/2x/razer-logo-png-transparent.png',
  rating: 4,
  brand: 'Sony',
  category: 'Electronics',

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
