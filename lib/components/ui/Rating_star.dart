import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  const RatingStar({super.key, required this.averageStar, required this.totalReviews});

  final int averageStar;
  final int totalReviews;

  @override
  Widget build(BuildContext context) {
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
}
