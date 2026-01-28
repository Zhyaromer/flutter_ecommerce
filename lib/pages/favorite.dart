import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/Rating_star.dart';
import 'package:flutter_ecommerce/model/SearchProducts.dart';
import 'package:flutter_ecommerce/pages/product_details.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late List<Searchproducts> favoriteItems;

  void _removeFromFavorites(Searchproducts item) {
    setState(() {
      favoriteItems.remove(item);
    });
  }

  @override
  void initState() {
    super.initState();
    favoriteItems = searchdummyProducts.take(10).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: favoriteItems.isEmpty
                ? const Center(
                    child: Text('No favorite items yet', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  )
                : ListView.builder(
                    itemCount: favoriteItems.length,
                    itemBuilder: (context, index) {
                      final item = favoriteItems[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsScreen(productId: item.id);
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 125,
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[700]!.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                child: Image.network(
                                  item.imageUrl,
                                  width: 130,
                                  height: 125,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 130,
                                      height: 125,
                                      color: Colors.grey,
                                      child: const Icon(Icons.broken_image, color: Colors.white),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            'IQD ${item.price.toStringAsFixed(3)}',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          const SizedBox(width: 8),

                                          if (item.oldPrice != null)
                                            Text(
                                              'IQD ${item.oldPrice!.toStringAsFixed(3)}',
                                              style: const TextStyle(
                                                color: Colors.white38,
                                                fontSize: 12,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                        ],
                                      ),

                                      RatingStar(averageStar: item.rating, totalReviews: item.reviews),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: () {
                                              _removeFromFavorites(item);
                                            },
                                            child: const Icon(Icons.favorite, color: Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
