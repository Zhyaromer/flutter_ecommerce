import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/Rating_star.dart';
import 'package:flutter_ecommerce/model/SearchProducts.dart';
import 'package:flutter_ecommerce/pages/product_details.dart';

class ProductCardDetails extends StatelessWidget {
  const ProductCardDetails({super.key, required this.products, this.isInStore = false});

  final List<Searchproducts> products;
  final bool isInStore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: isInStore,
      physics: isInStore ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
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

                          RatingStar(averageStar: product.rating, totalReviews: product.reviews),

                          const SizedBox(height: 8),

                          product.stock == 0
                              ? Text(
                                  'Out of Stock',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent),
                                )
                              : product.stock > 10
                              ? Text(
                                  'In Stock',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                  ),
                                )
                              : Text(
                                  'Only ${product.stock} left in stock - order soon.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orangeAccent,
                                  ),
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
}
