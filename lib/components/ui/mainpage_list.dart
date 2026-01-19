import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/Products.dart';
import 'package:flutter_ecommerce/pages/product_details.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.mockData, required this.title, required this.navigate});

  final List<Product> mockData;
  final String title;
  final VoidCallback navigate;

  Widget _ratingStars(int averageStar, int totalReviews) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(averageStar, (index) => Icon(Icons.star, color: Colors.amber, size: 16)),

        ...List.generate(5 - averageStar, (index) => Icon(Icons.star_border, color: Colors.amber, size: 16)),

        const SizedBox(width: 5),

        Text('($totalReviews)', style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: navigate,
                child: Row(
                  children: const [
                    Text('See All', style: TextStyle(color: Colors.grey, fontSize: 14)),

                    SizedBox(width: 4),

                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemCount: mockData.length,
              itemBuilder: (context, index) {
                final product = mockData[index];
                return InkWell(
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
                    decoration: BoxDecoration(color: Colors.grey[850], borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: 175,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(product.imageUrl, fit: BoxFit.cover),
                          ),
                        ),

                        const SizedBox(height: 5),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ratingStars(product.rating, product.reviews),
                                SizedBox(height: 5),
                                Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      product.isDiscount ? '\$${product.price}' : '\$${product.price}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    if (product.isDiscount)
                                      Text(
                                        '\$${product.oldPrice}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
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
