import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/Card.dart';
import 'package:flutter_ecommerce/model/Products.dart';

class SectionsCard extends StatelessWidget {
  final List<Product> mockProduct;
  final String title;

  const SectionsCard({super.key, required this.mockProduct, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 700,
        width: 350,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey[900]),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  InkWell(
                    onTap: () {
                      // Navigate to see all top brands
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ProductCard(products: mockProduct),
            ],
          ),
        ),
      ),
    );
  }
}
