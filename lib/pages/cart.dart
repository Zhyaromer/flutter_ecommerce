import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/CartProducts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final TextEditingController cuponController = TextEditingController();
  List<Cartproducts> cartItems = [];
  double discountPercentage = 0.0;
  String appliedCuponCode = '';

  double get calculateTotal {
    double currentSubtotal = cartItems.fold(0, (sum, item) => sum + item.totalPrice);
    double couponAmount = currentSubtotal * discountPercentage;
    return currentSubtotal - couponAmount;
  }

  double get calculateSavings {
    return cartItems.fold(0, (sum, item) => sum + (item.totalSavings ?? 0));
  }

  double get calculateTotalOldPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.totalOldPrice ?? 0));
  }

  void applyCuponCode(String code) {
    if (code == appliedCuponCode) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coupon already applied.')));
    } else if (code == 'd10') {
      setState(() {
        discountPercentage = 0.10;
        appliedCuponCode = code;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Coupon code applied! 10% discount added.')));
    } else if (code == 'd50' && appliedCuponCode != 'd50') {
      setState(() {
        discountPercentage = 0.50;
        appliedCuponCode = code;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Coupon code applied! 50% discount added.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid coupon code.')));
    }
  }

  @override
  void initState() {
    super.initState();
    cartItems = cartItemsdata;
  }

  @override
  void dispose() {
    cuponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.grey)),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        height: 170,
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[700]!.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)),
                                  child: Image.network(
                                    item.productImage,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey,
                                        child: const Icon(Icons.broken_image, color: Colors.white),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(height: 25),
                                            Text(
                                              'IQD ${item.price.toStringAsFixed(3)}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            if (item.oldPrice != null)
                                              Text(
                                                'IQD ${item.oldPrice!.toStringAsFixed(3)}',
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 6),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.grey[700]!),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    child: Icon(
                                                      item.quantity > 1 ? Icons.remove : Icons.delete,
                                                      color: item.quantity == 1 ? Colors.white60 : Colors.white,
                                                      size: 17,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        if (item.quantity > 1) {
                                                          item.decrementQuantity();
                                                        } else {
                                                          item.removeFromCart(item.id);
                                                        }
                                                      });
                                                    },
                                                  ),

                                                  const SizedBox(width: 8),

                                                  Text(
                                                    item.quantity.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),

                                                  const SizedBox(width: 8),

                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (item.quantity < item.maxQuantity) {
                                                          item.incrementQuantity();
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 17,
                                                      color: item.quantity < item.maxQuantity
                                                          ? Colors.white
                                                          : Colors.white60,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Container(height: 1, color: Colors.grey[800]),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    'Quantity',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    'Total Price',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Text(
                                    'IQD ${item.totalPriceforeachitem.toStringAsFixed(3)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Color(0xFF2C2C2C)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cupon',
                            style: TextStyle(
                              color: Colors.white70.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        TextFormField(
                          controller: cuponController,
                          style: const TextStyle(color: Colors.white),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a cupon code';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter your cupon code',
                            errorStyle: const TextStyle(color: Colors.red),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            labelStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: ElevatedButton(
                              onPressed: () {
                                applyCuponCode(cuponController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text('Apply', style: TextStyle(color: Colors.white)),
                            ),
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Payment Summary',
                            style: TextStyle(
                              color: Colors.white70.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Subtotal", style: TextStyle(color: Colors.white70, fontSize: 14)),
                            Text(
                              "IQD ${calculateTotalOldPrice.toStringAsFixed(3)}",
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),
                        Container(height: 2, color: Colors.grey[700]),
                        const SizedBox(height: 6),

                        if (calculateSavings > 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Discounted", style: TextStyle(color: Colors.white70, fontSize: 14)),
                              Text(
                                "- IQD ${calculateSavings.toStringAsFixed(3)}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 240, 84, 73),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(height: 2, color: Colors.grey[700]),
                          const SizedBox(height: 6),
                        ],

                        if (discountPercentage > 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Coupon', style: TextStyle(color: Colors.white70, fontSize: 14)),
                              Text(
                                "- IQD ${(cartItems.fold(0.0, (sum, item) => sum + item.totalPrice) * discountPercentage).toStringAsFixed(3)}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 240, 84, 73),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(height: 2, color: Colors.grey[700]),
                          const SizedBox(height: 6),
                        ],

                        if (calculateSavings > 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Final Price', style: TextStyle(color: Colors.white70, fontSize: 14)),
                              Text(
                                'IQD ${calculateTotal.toStringAsFixed(3)}',
                                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 6),
                        Container(height: 2, color: Colors.grey[700]),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'CHECKOUT',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
