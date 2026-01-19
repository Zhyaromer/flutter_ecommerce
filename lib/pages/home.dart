import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/ui/Card.dart';
import 'package:flutter_ecommerce/components/ui/mainpage_list.dart';
import 'package:flutter_ecommerce/components/ui/search_field.dart';
import 'package:flutter_ecommerce/components/ui/sections_card.dart';
import 'package:flutter_ecommerce/components/ui/top_brands.dart';
import 'package:flutter_ecommerce/model/TopBrands.dart';
import 'package:flutter_ecommerce/model/Products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _search(String query) {
    print('Searching for: $query');
  }

  List<Map<String, dynamic>> exclusiveOffers = [
    {'title': 'Electronics Deals', 'products': mockProducts3},
    {'title': 'Fashion Finds', 'products': mockProducts3},
    {'title': 'Home Essentials', 'products': mockProducts3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover Products',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        shadowColor: Colors.black,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 28),
                onPressed: () {
                  // Navigate to cart page
                },
              ),
              Positioned(
                right: 8,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      SearchField(
                        label: 'Search for products',
                        controller: _searchController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a search term';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _search(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            'https://static.vecteezy.com/system/resources/thumbnails/002/006/774/small/paper-art-shopping-online-on-smartphone-and-new-buy-sale-promotion-backgroud-for-banner-market-ecommerce-free-vector.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ProductsList(
                      mockData: mockProducts,
                      title: 'Best Selling',
                      navigate: () {
                        // Navigate to see all best selling products
                      },
                    ),

                    const SizedBox(height: 15),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Exclusive Offers',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 720,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: exclusiveOffers.length,
                            itemBuilder: (context, index) {
                              final offer = exclusiveOffers[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 350,
                                  child: SectionsCard(mockProduct: offer['products'], title: offer['title']),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 10),

                    ProductsList(
                      mockData: mockProducts2,
                      title: 'Recommended for You',
                      navigate: () {
                        // Navigate to see all best selling products
                      },
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 20),

                    Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://www.zilliondesigns.com/blog/wp-content/uploads/Ecommerce-sales-banner.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[800],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(
                                  'https://i.pinimg.com/736x/1e/3b/c1/1e3bc1357eedac258388c1508d2c00e7.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[700],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                        'https://static.vecteezy.com/system/resources/previews/062/687/510/non_2x/vibrant-square-green-mega-sale-banner-with-floating-abstract-shapes-and-bold-typography-ideal-for-seasonal-sales-ecommerce-promos-and-ad-campaigns-vector.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[700],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                        'https://static.vecteezy.com/system/resources/thumbnails/062/687/720/small/minimal-white-background-square-mega-sale-banner-with-floating-3d-platform-ideal-for-product-promotion-modern-ecommerce-and-clean-marketing-layouts-vector.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 10),

                    ProductsList(
                      mockData: mockProducts,
                      title: 'Best Selling',
                      navigate: () {
                        // Navigate to see all best selling products
                      },
                    ),

                    const SizedBox(height: 10),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 10),

                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.99,
                      ),
                      items:
                          [
                            buildBanner('https://i.ytimg.com/vi/f64GdOxJjPE/maxresdefault.jpg'),
                            buildBanner(
                              'https://graphicsfamily.com/wp-content/uploads/edd/2022/11/Simple-E-commerce-Banner-Design-scaled.jpg',
                            ),
                            buildBanner(
                              'https://graphicsfamily.com/wp-content/uploads/edd/2023/06/E-commerce-Website-Product-Banner-Design-scaled.jpg',
                            ),
                          ].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(child: i);
                              },
                            );
                          }).toList(),
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 20),

                    TopBrandsWidget(brandsData: brandList),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Exclusive Offers',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 720,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: exclusiveOffers.length,
                            itemBuilder: (context, index) {
                              final offer = exclusiveOffers[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 350,
                                  child: SectionsCard(mockProduct: offer['products'], title: offer['title']),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 10),

                    Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://pixelixe.com/blog/images/250/e-commerce-banner-strategy.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[800],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(
                                  'https://i.pinimg.com/736x/1e/3b/c1/1e3bc1357eedac258388c1508d2c00e7.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[700],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                        'https://static.vecteezy.com/system/resources/previews/062/687/510/non_2x/vibrant-square-green-mega-sale-banner-with-floating-abstract-shapes-and-bold-typography-ideal-for-seasonal-sales-ecommerce-promos-and-ad-campaigns-vector.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[700],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                        'https://static.vecteezy.com/system/resources/thumbnails/062/687/720/small/minimal-white-background-square-mega-sale-banner-with-floating-3d-platform-ideal-for-product-promotion-modern-ecommerce-and-clean-marketing-layouts-vector.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://i.pinimg.com/736x/e6/e6/4f/e6e64f9ab1e500dc262d789e8579217f.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey[700], thickness: 1),

                    const SizedBox(height: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Exclusive Offers',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 720,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: exclusiveOffers.length,
                            itemBuilder: (context, index) {
                              final offer = exclusiveOffers[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 350,
                                  child: SectionsCard(mockProduct: offer['products'], title: offer['title']),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBanner(String imageUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity),
  );
}
