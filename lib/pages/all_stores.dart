import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/search_field.dart';
import 'package:flutter_ecommerce/model/Stores.dart';
import 'package:flutter_ecommerce/pages/Store_details.dart';

class AllStores extends StatefulWidget {
  const AllStores({super.key});

  @override
  State<AllStores> createState() => _AllStoresState();
}

class _AllStoresState extends State<AllStores> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounce;
  List<Stores> _searchResults = [];
  bool isLoading = false;
  bool isEmpty = false;

  void _onSearchChanged(String query, {bool triggerSuggestions = true}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      if (query.trim().isEmpty) {
        setState(() {
          _searchResults = storeDataset;
          isEmpty = false;
          isLoading = false;
        });
        return;
      }

      setState(() {
        isLoading = true;
      });

      final searchLower = query.toLowerCase().trim();
      final results = storeDataset.where((store) {
        return store.name.toLowerCase().contains(searchLower);
      }).toList();

      setState(() {
        _searchResults = results;
        isEmpty = results.isEmpty;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _searchResults = storeDataset;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
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
                      Expanded(
                        child: SearchField(
                          label: 'Search for Stores',
                          controller: _searchController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a search term';
                            }
                            return null;
                          },
                          searchFocusNode: _searchFocusNode,
                          onChanged: (value) {
                            _onSearchChanged(value, triggerSuggestions: true);
                          },
                          onSubmitted: (value) {
                            _onSearchChanged(value, triggerSuggestions: false);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : isEmpty
                ? const Center(child: Text('No stores found.', style: TextStyle(fontSize: 18)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final store = _searchResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StoreDetails(storeId: store.id)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[800]!.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    store.imageUrl,
                                    width: 150,
                                    height: 120,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 150,
                                      height: 120,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.store),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          store.name,
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(store.rating.toString(), style: const TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          store.description,
                                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),

                                        if (store.location != null && store.location!.isNotEmpty)
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on, color: Colors.redAccent, size: 16),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  store.location?[0].address ?? '',
                                                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
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
