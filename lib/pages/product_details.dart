import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/mainpage_list.dart';
import 'package:flutter_ecommerce/model/ProductDetails.dart';
import 'package:flutter_ecommerce/model/Products.dart';

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
  final TextEditingController _quantityController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _selectVariant(int index) {
    setState(() {
      _quantityController.text = '1';
      _selectedVariantIndex = index;
    });
  }

  void _incrementQuantity() {
    int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
    setState(() {
      currentQuantity++;
      _quantityController.text = currentQuantity.toString();
    });
  }

  void _decrementQuantity() {
    int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
    if (currentQuantity > 1) {
      setState(() {
        currentQuantity--;
        _quantityController.text = currentQuantity.toString();
      });
    }
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

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            '\$${mockProductDetail.variants[_selectedVariantIndex].price.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.grey[400], fontSize: 28, fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(width: 10),

                          if (mockProductDetail.variants[_selectedVariantIndex].oldPrice != null)
                            Text(
                              '\$${mockProductDetail.variants[_selectedVariantIndex].oldPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        mockProductDetail.variants[_selectedVariantIndex].stock > 0 ? 'In Stock' : 'Out of Stock',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mockProductDetail.variants[_selectedVariantIndex].stock > 0
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _decrementQuantity,
                          child: const Text(
                            '-',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Text(
                          '  ${_quantityController.text}  ',
                          style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
                            if (currentQuantity < mockProductDetail.variants[_selectedVariantIndex].stock) {
                              _incrementQuantity();
                            }
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: mockProductDetail.variants[_selectedVariantIndex].stock > 0 ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey[800], thickness: 1),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Product Description',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        mockProductDetail.description,
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey[800], thickness: 1),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About The Product',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ListView.builder(
                      itemBuilder: (context, index) {
                        final feature = mockProductDetail.features[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 6),
                          child: Row(
                            children: [
                              Icon(Icons.circle, color: Colors.deepPurpleAccent, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(feature, style: TextStyle(color: Colors.grey[200], fontSize: 16)),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: mockProductDetail.features.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),

                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Top Highlights',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ListView.builder(
                      itemBuilder: (context, index) {
                        final feature = mockProductDetail.aboutTheProduct[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check, color: Colors.green, size: 16, fontWeight: FontWeight.bold),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(feature, style: TextStyle(color: Colors.grey[200], fontSize: 16)),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: mockProductDetail.aboutTheProduct.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),

                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Specifications',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Column(
                      children: mockProductDetail.specifications.entries.toList().asMap().entries.map((mapEntry) {
                        final index = mapEntry.key;
                        final entry = mapEntry.value;
                        return Column(
                          children: [
                            index != 0
                                ? Container()
                                : Divider(color: Colors.grey[800], thickness: 1, indent: 16, endIndent: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(entry.key, style: TextStyle(color: Colors.grey[400], fontSize: 16)),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      entry.value,
                                      style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[800], thickness: 1, indent: 16, endIndent: 16),
                          ],
                        );
                      }).toList(),
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('brand', style: TextStyle(color: Colors.grey[400], fontSize: 16)),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  mockProductDetail.brand,
                                  style: TextStyle(color: Colors.grey[200], fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(color: Colors.grey[800], thickness: 1, indent: 16, endIndent: 16),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('category', style: TextStyle(color: Colors.grey[400], fontSize: 16)),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  mockProductDetail.category,
                                  style: TextStyle(color: Colors.grey[200], fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Divider(color: Colors.grey[800], thickness: 1),

                    const SizedBox(height: 20),

                    ProductsList(
                      mockData: mockProducts,
                      showSeeAll: false,
                      title: 'similar products',
                      navigate: () {
                        // Navigate
                      },
                    ),

                    const SizedBox(height: 10),

                    Divider(color: Colors.grey[800], thickness: 1),

                    const SizedBox(height: 20),

                    ProductsList(
                      mockData: mockProducts,
                      showSeeAll: false,
                      title: 'related categories products',
                      navigate: () {
                        // Navigate
                      },
                    ),

                    const SizedBox(height: 10),

                    Divider(color: Colors.grey[800], thickness: 1),

                    const SizedBox(height: 20),

                    ProductsList(
                      mockData: mockProducts,
                      showSeeAll: false,
                      title: 'more from this brand',
                      navigate: () {
                        // Navigate
                      },
                    ),

                    const SizedBox(height: 30),

                    Divider(color: Colors.grey[800], thickness: 1),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews & Ratings (${mockProductDetail.reviews.length})',
                          style: TextStyle(color: Colors.grey[200], fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            'Write a review',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final review = mockProductDetail.TopReviews()[index];
                          return Container(
                            width: 300,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1B1F),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey[800] ?? Colors.grey, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.deepPurpleAccent,
                                        child: Text(
                                          review.userName.isNotEmpty ? review.userName[0] : 'U',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.userName,
                                            style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          _ratingStars(review.rating, 1),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),
                                  Text(
                                    review.comment,
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: mockProductDetail.reviews.length,
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(
                        'See More Reviews',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
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
