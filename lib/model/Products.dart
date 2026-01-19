class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? oldPrice; // Null if no discount
  final int rating;
  final int reviews;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.reviews,
  });

  bool get isDiscount => oldPrice != null && oldPrice! > price;
}

final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'iPhone 17 Pro Max Ultra',
    imageUrl: 'https://picsum.photos/id/160/600/400',
    price: 999.0,
    oldPrice: 1199.0,
    rating: 5,
    reviews: 128,
  ),
  Product(
    id: '2',
    name: 'MacBook Air M3 13"',
    imageUrl: 'https://picsum.photos/id/0/600/400',
    price: 1099.0,
    rating: 4,
    reviews: 85,
  ),
  Product(
    id: '3',
    name: 'Sony WH-1000XM5',
    imageUrl: 'https://picsum.photos/id/48/600/400',
    price: 349.0,
    oldPrice: 399.0,
    rating: 5,
    reviews: 210,
  ),
  Product(
    id: '4',
    name: 'Apple Watch Series 10',
    imageUrl: 'https://picsum.photos/id/175/600/400',
    price: 399.0,
    rating: 4,
    reviews: 56,
  ),
  Product(
    id: '5',
    name: 'iPad Pro 12.9 Inch',
    imageUrl: 'https://picsum.photos/id/180/600/400',
    price: 1299.0,
    oldPrice: 1499.0,
    rating: 5,
    reviews: 92,
  ),
  Product(
    id: '6',
    name: 'AirPods Max Sky Blue',
    imageUrl: 'https://picsum.photos/id/373/600/400',
    price: 549.0,
    rating: 4,
    reviews: 340,
  ),
];

final List<Product> mockProducts2 = [
  Product(
    id: '7',
    name: 'Sony WH-1000XM5 Wireless Noise Canceling Headphones',
    imageUrl: 'https://images.unsplash.com/photo-1613243555988-441166d4d6fd?q=80&w=500&auto=format&fit=crop',
    price: 348.0,
    oldPrice: 399.99,
    rating: 5,
    reviews: 2450,
  ),
  Product(
    id: '8',
    name: 'Samsung Galaxy Watch 6 Classic',
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=500&auto=format&fit=crop',
    price: 299.0,
    rating: 4,
    reviews: 890,
  ),
  Product(
    id: '9',
    name: 'Logitech MX Master 3S Wireless Mouse',
    imageUrl: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?q=80&w=500&auto=format&fit=crop',
    price: 99.0,
    oldPrice: 129.0,
    rating: 5,
    reviews: 120,
  ),
  Product(
    id: '10',
    name: 'Dell UltraSharp 27" 4K Monitor',
    imageUrl: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?q=80&w=500&auto=format&fit=crop',
    price: 589.0,
    rating: 4,
    reviews: 432,
  ),
  Product(
    id: '11',
    name: 'Nintendo Switch OLED Model - Neon Blue/Red',
    imageUrl: 'https://images.unsplash.com/photo-1578303372216-4147ea3d74aa?q=80&w=500&auto=format&fit=crop',
    price: 349.0,
    oldPrice: 379.0,
    rating: 5,
    reviews: 5600,
  ),
];

final List<Product> mockProducts3 = [
  Product(
    id: '12',
    name: 'Sony WH-1000XM5 Wireless Noise Canceling Headphones',
    imageUrl: 'https://images.unsplash.com/photo-1613243555988-441166d4d6fd?q=80&w=500&auto=format&fit=crop',
    price: 348.0,
    oldPrice: 399.99,
    rating: 5,
    reviews: 2450,
  ),
  Product(
    id: '13',
    name: 'Samsung Galaxy Watch 6 Classic',
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=500&auto=format&fit=crop',
    price: 299.0,
    rating: 4,
    reviews: 890,
  ),
  Product(
    id: '14',
    name: 'Logitech MX Master 3S Wireless Mouse',
    imageUrl: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?q=80&w=500&auto=format&fit=crop',
    price: 99.0,
    oldPrice: 129.0,
    rating: 5,
    reviews: 120,
  ),
  Product(
    id: '15',
    name: 'Dell UltraSharp 27" 4K Monitor',
    imageUrl: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?q=80&w=500&auto=format&fit=crop',
    price: 589.0,
    rating: 4,
    reviews: 432,
  ),
];
