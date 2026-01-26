import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/search_field.dart';
import 'package:flutter_ecommerce/model/SearchProducts.dart';
import 'package:flutter_ecommerce/pages/product_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  int stock = 1;
  List<Searchproducts> _searchResults = [];
  Timer? _debounce;
  bool isLoading = false;
  bool isEmpty = false;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      setState(() {
        isLoading = true;
      });

      if (query.isEmpty) {
        setState(() {
          _searchResults = [];
          isEmpty = true;
          isLoading = false;
        });
        return;
      }

      final searchLower = query.toLowerCase();

      final results = searchdummyProducts.where((product) {
        return product.name.toLowerCase().contains(searchLower) ||
            product.description.toLowerCase().contains(searchLower);
      }).toList();

      setState(() {
        _searchResults = results;
        isEmpty = results.isEmpty;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.deepPurpleAccent, elevation: 0, automaticallyImplyLeading: false),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 27),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SearchField(
                          label: 'Search for products',
                          controller: _searchController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a search term';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _onSearchChanged(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          _searchController.text.isEmpty
              ? Expanded(
                  child: Center(
                    child: SizedBox(height: 300, child: Image(image: AssetImage('assets/images/Search-rafiki.png'))),
                  ),
                )
              : SizedBox.shrink(),

          if (isLoading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (isEmpty && _searchController.text.isNotEmpty)
            Expanded(
              child: Center(
                child: Text('No products found.', style: TextStyle(fontSize: 18, color: Colors.white54)),
              ),
            )
          else if (_searchController.text.isNotEmpty)
            Expanded(child: _buildCards(_searchResults)),
        ],
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
      totalReviews > 0
          ? Text('($totalReviews)', style: const TextStyle(color: Colors.grey, fontSize: 12))
          : const SizedBox.shrink(),
    ],
  );
}

Widget _buildCards(List<Searchproducts> products) {
  return ListView.builder(
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProductDetailsScreen(productId: product.id);
                },
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 3, offset: const Offset(0, 2))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 210,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: product.isDiscount ? Colors.green : Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            if (product.isDiscount) ...[
                              Text(
                                '\$${product.oldPrice!.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white54,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),

                        Text(
                          product.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          product.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white54),
                        ),

                        const SizedBox(height: 8),

                        _ratingStars(product.rating, product.reviews),

                        const SizedBox(height: 8),

                        product.stock == 0
                            ? Text(
                                'Out of Stock',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent),
                              )
                            : product.stock > 10
                            ? Text(
                                'In Stock',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                              )
                            : Text(
                                'Only ${product.stock} left in stock - order soon.',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
