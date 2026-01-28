import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/Product_card_details.dart';
import 'package:flutter_ecommerce/components/ui/search_field.dart';
import 'package:flutter_ecommerce/model/SearchProducts.dart';
import 'package:flutter_ecommerce/model/Stores.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({super.key, required this.storeId});

  final String storeId;

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  final TextEditingController controller = TextEditingController();
  List<Searchproducts> _searchResults = [];
  Stores? store;
  Timer? _debounce;
  bool isLoading = false;
  bool isEmpty = false;
  bool isModalOpen = false;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      setState(() {
        isLoading = true;
      });

      if (query.isEmpty) {
        setState(() {
          _searchResults = searchdummyProducts;
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

  void _openModal() {
    if (isModalOpen) return;

    setState(() {
      isModalOpen = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          height: screenHeight * 0.8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                ),
              ),

              const SizedBox(height: 10),

              if (store?.location != null) ...[
                const Text(
                  'Locations',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...store!.location!.map(
                  (location) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${location.name} - ${location.address}',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              const Text(
                'Contacts',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...store!.contact.map(
                (contact) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.phone, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${contact.name} - ${contact.phoneNumber}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (store?.socials != null) ...[
                const Text(
                  'Socials',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                ...store!.socials!.map(
                  (social) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.public, color: Colors.blue, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${social.name} - ${social.url}',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        isModalOpen = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _searchResults = searchdummyProducts;
    store = storeDataset.firstWhere((store) => store.id == widget.storeId);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Store Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    store?.imageUrl ?? 'https://cdn.wccftech.com/wp-content/uploads/2017/10/Razer-logo.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              store?.imageUrl ?? 'https://cdn.wccftech.com/wp-content/uploads/2017/10/Razer-logo.jpg',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store?.name ?? 'Razer Store',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('⭐ 4 (120)', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),

                  IconButton(
                    onPressed: () {
                      _openModal();
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: SearchField(
                label: 'search for products',
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a search term';
                  }
                  return null;
                },
                onChanged: (value) {
                  _onSearchChanged(value);
                },
                circularBorderRadius: 8,
                filedColor: Color(0xFF1E1E1E),
                cursorColor: Colors.white,
                iconColor: Colors.white,
                hintColor: Colors.white54,
              ),
            ),

            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (isEmpty && controller.text.isNotEmpty)
              Center(
                child: Text('No products found.', style: TextStyle(fontSize: 18, color: Colors.white54)),
              )
            else
              ProductCardDetails(products: _searchResults, isInStore: true),
          ],
        ),
      ),
    );
  }
}
