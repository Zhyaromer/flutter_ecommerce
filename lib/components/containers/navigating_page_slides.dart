import 'package:flutter/material.dart';

class NavigatingPageSlides extends StatelessWidget {
  const NavigatingPageSlides({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: currentPage == 0 ? Colors.deepPurpleAccent : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: currentPage == 1 ? Colors.deepPurpleAccent : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: currentPage == 2 ? Colors.deepPurpleAccent : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
