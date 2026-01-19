import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/TopBrands.dart';

class TopBrandsWidget extends StatelessWidget {
  const TopBrandsWidget({super.key, required this.brandsData});

  final List<TopBrands> brandsData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Brands',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: brandsData.length,
              itemBuilder: (context, index) {
                final brand = brandsData[index];
                return InkWell(
                  onTap: () {
                    // Handle brand tap
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Image.network(brand.imageUrl, width: 160, height: 130, fit: BoxFit.contain)),
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
