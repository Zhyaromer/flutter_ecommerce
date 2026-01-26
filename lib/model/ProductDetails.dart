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

  List<Review> TopReviews() {
    return reviews.take(10).toList();
  }

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
      comment:
          'worst product ever! broke after one week of use, very disappointed, would not recommend to anyone, save your money, terrible quality,why did I even buy this, complete waste of money, do not buy!,worst product ever! broke after one week of use, very disappointed, would not recommend to anyone, save your money, terrible quality,why did I even buy this, complete waste of money, do not buy!',
      rating: 1,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '2',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Mary Williams',
      comment: 'good product but could be better',
      rating: 3,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '3',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Kevin Brown',
      comment: 'Average quality, expected more for the price.',
      rating: 4,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '4',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Emily Davis',
      comment: 'Good value for the price.',
      rating: 2,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '5',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Michael Scott',
      comment: 'Best headphones I have ever owned!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '6',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Pam Beesly',
      comment: 'Good value for the price.',
      rating: 4,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '7',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
    Review(
      userName: 'Jim Halpert',
      comment: 'one of the best purchases I have made recently!',
      rating: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      id: '8',
      productId: 'p1',
      userId: 'u1',
    ),
  ],

  relatedProducts: ['p2', 'p3'],
  relatedProductsByCategory: ['p10', 'p11'],
  relatedProductsByBrand: ['p5', 'p6'],
);
