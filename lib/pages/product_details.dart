import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ProductDetails.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedVariantIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectVariant(int index) {
    setState(() {
      _selectedVariantIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                      ),
                      child: Image.network(mockProductDetail.storeImageUrl, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mockProductDetail.storeName,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text('Visit The Store', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    _ratingStars(mockProductDetail.rating.toInt(), 234),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  mockProductDetail.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                ),
              ),

              const SizedBox(height: 20),

              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: mockProductDetail.variants[_selectedVariantIndex].imageUrls.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _openFullScreenImage(context, index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                mockProductDetail.variants[_selectedVariantIndex].imageUrls[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          mockProductDetail.variants[_selectedVariantIndex].imageUrls.length,
                          (index) => _buildDot(index),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.favorite, color: Colors.grey[400]),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.share, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),

              Divider(color: Colors.grey[800], thickness: 1),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Color:', style: TextStyle(color: Colors.grey[400])),
                        const SizedBox(width: 10),
                        Text(
                          mockProductDetail.variants[_selectedVariantIndex].color,
                          style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mockProductDetail.variants.length,
                        itemBuilder: (context, index) {
                          final variant = mockProductDetail.variants[index];
                          final isSelected = index == _selectedVariantIndex;
                          return GestureDetector(
                            onTap: () => _selectVariant(index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C1B1F),
                                borderRadius: BorderRadius.circular(20),
                                border: isSelected
                                    ? Border.all(color: Colors.deepPurpleAccent, width: 2)
                                    : Border.all(color: Colors.grey, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.network(variant.imageUrls[0], width: 110, height: 110, fit: BoxFit.cover),

                                  const SizedBox(height: 4),

                                  Text(
                                    variant.color,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    '\$${variant.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    variant.stock > 0 ? 'In Stock' : 'Out of Stock',
                                    style: TextStyle(
                                      color: variant.stock > 0 ? Colors.greenAccent : Colors.redAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey[800], thickness: 1),

                    const SizedBox(height: 10),

                    Text(
                      '\$${mockProductDetail.variants[_selectedVariantIndex].price.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.deepPurpleAccent : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: PageView.builder(
            itemCount: mockProductDetail.variants[_selectedVariantIndex].imageUrls.length,
            controller: PageController(initialPage: initialIndex),
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(mockProductDetail.variants[_selectedVariantIndex].imageUrls[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _ratingStars(int averageStar, int totalReviews) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...List.generate(5, (index) {
        return Icon(index < averageStar ? Icons.star : Icons.star_border, color: Colors.amber, size: 16);
      }),
      const SizedBox(width: 5),
      Text('($totalReviews)', style: const TextStyle(color: Colors.grey, fontSize: 12)),
    ],
  );
}
