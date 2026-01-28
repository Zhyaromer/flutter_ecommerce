import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/Product_card_details.dart';
import 'package:flutter_ecommerce/components/ui/search_field.dart';
import 'package:flutter_ecommerce/model/SearchProducts.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<Searchproducts> _searchResults = [];
  List<String> _suggestions = [];
  Timer? _debounce;
  bool isLoading = false;
  bool isEmpty = false;
  bool showSuggestions = true;

  void _onSearchChanged(String query, {bool triggerSuggestions = true}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      setState(() {
        isLoading = true;
      });

      if (query.isEmpty) {
        setState(() {
          _searchResults = [];
          isEmpty = true;
          isLoading = false;
          showSuggestions = true;
          _suggestions = [];
        });
        return;
      }

      final searchLower = query.toLowerCase();
      final results = searchdummyProducts.where((product) {
        return product.name.toLowerCase().contains(searchLower) ||
            product.description.toLowerCase().contains(searchLower);
      }).toList();

      final suggestions = results.take(5).map((product) => product.name).toList();

      setState(() {
        _searchResults = results;
        isEmpty = results.isEmpty;
        isLoading = false;
        _suggestions = suggestions;
        showSuggestions = triggerSuggestions;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
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
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 27),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SearchField(
                          label: 'Search for products',
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

          _searchController.text.isEmpty
              ? Expanded(
                  child: Center(
                    child: SizedBox(height: 300, child: Image(image: AssetImage('assets/images/Search-rafiki.png'))),
                  ),
                )
              : SizedBox.shrink(),

          if (isLoading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (showSuggestions && _searchController.text.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final text = _suggestions[index];
                  return ListTile(
                    leading: const Icon(Icons.search, color: Colors.white54),
                    title: Text(text, style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      _searchController.text = text;
                      isLoading = true;
                      _onSearchChanged(text, triggerSuggestions: false);
                      setState(() {
                        showSuggestions = false;
                      });
                    },
                  );
                },
              ),
            )
          else if (isEmpty && _searchController.text.isNotEmpty)
            Expanded(
              child: Center(
                child: Text('No products found.', style: TextStyle(fontSize: 18, color: Colors.white54)),
              ),
            )
          else if (_searchController.text.isNotEmpty)
            Expanded(child: ProductCardDetails(products: _searchResults)),
        ],
      ),
    );
  }
}
