import 'package:flutter/material.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({super.key, required this.storeId});

  final String storeId;

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Store Details Page')));
  }
}
