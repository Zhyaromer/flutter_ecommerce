class Cartproducts {
  final int id;
  final String productID;
  final String storeID;
  final String productName;
  final String productImage;
  final double price;
  final double? oldPrice;
  int quantity;
  final int maxQuantity;

  Cartproducts({
    required this.id,
    required this.productID,
    required this.storeID,
    required this.productName,
    required this.productImage,
    required this.price,
    this.oldPrice,
    required this.quantity,
    required this.maxQuantity,
  });

  double get totalPrice => price * quantity;

  double? get totalOldPrice => oldPrice != null ? oldPrice! * quantity : null;

  double? get totalSavings => oldPrice != null ? (oldPrice! - price) * quantity : null;

  double get applyDiscountPercent {
    if (oldPrice != null && oldPrice! > 0) {
      return ((oldPrice! - price) / oldPrice!) * 100;
    }
    return 0;
  }

  double get totalPriceforeachitem {
    return price * quantity;
  }

  void incrementQuantity() {
    if (quantity < maxQuantity) {
      quantity += 1;
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity -= 1;
    }
  }

  void removeFromCart(int id) {
    cartItemsdata.removeWhere((item) => item.id == id);
  }
}

List<Cartproducts> cartItemsdata = [
  // 1. Standard discounted electronics
  Cartproducts(
    id: 1,
    productID: "PROD-001",
    storeID: "TECH-ZONE",
    productName: "Wireless Noise-Canceling Headphones",
    productImage:
        "https://i5.walmartimages.com/seo/GAN356-M-E-3x3-Magnetic-Speed-Cube-Stickerless-48-Magnets-Puzzle-Toys-for-Kids-Adult_3d58e8a4-670d-4f8a-87c0-f1a5c27a84da.5b83ed2faccaecaa9fbf39dfac16cf57.jpeg?odnHeight=2000&odnWidth=2000&odnBg=FFFFFF",
    price: 199.99,
    oldPrice: 249.99,
    quantity: 1,
    maxQuantity: 5,
  ),

  // 2. High-quantity pantry staple
  Cartproducts(
    id: 2,
    productID: "PROD-002",
    storeID: "GROCERY-HUB",
    productName: "Organic Oat Milk (1L)",
    productImage: "https://example.com/images/oatmilk.jpg",
    price: 4.50,
    oldPrice: null, // No discount
    quantity: 6,
    maxQuantity: 12,
  ),

  // 3. Item at Maximum Quantity limit
  Cartproducts(
    id: 3,
    productID: "PROD-003",
    storeID: "FASHION-X",
    productName: "Cotton Crewneck T-Shirt",
    productImage: "https://example.com/images/tshirt.jpg",
    price: 15.00,
    oldPrice: 20.00,
    quantity: 3,
    maxQuantity: 3, // Maxed out
  ),

  // 4. Luxury item with high discount
  Cartproducts(
    id: 4,
    productID: "PROD-004",
    storeID: "LUXE-WATCH",
    productName: "Midnight Quartz Watch",
    productImage: "https://example.com/images/watch.jpg",
    price: 450.00,
    oldPrice: 850.00,
    quantity: 1,
    maxQuantity: 2,
  ),

  // 5. Cheap add-on item
  Cartproducts(
    id: 5,
    productID: "PROD-005",
    storeID: "GROCERY-HUB",
    productName: "Eco-Friendly Paper Straws (50pk)",
    productImage: "https://example.com/images/straws.jpg",
    price: 1.25,
    oldPrice: 1.50,
    quantity: 2,
    maxQuantity: 20,
  ),

  // 6. Bulk office supply (No discount)
  Cartproducts(
    id: 6,
    productID: "PROD-006",
    storeID: "OFFICE-DEPOT",
    productName: "A4 Printer Paper (Box of 5)",
    productImage: "https://example.com/images/paper.jpg",
    price: 35.99,
    oldPrice: null,
    quantity: 1,
    maxQuantity: 10,
  ),

  // 7. Hardware/Home improvement
  Cartproducts(
    id: 7,
    productID: "PROD-007",
    storeID: "BUILD-IT",
    productName: "LED Smart Bulb (RGB)",
    productImage: "https://example.com/images/bulb.jpg",
    price: 12.99,
    oldPrice: 18.00,
    quantity: 4,
    maxQuantity: 15,
  ),
];
