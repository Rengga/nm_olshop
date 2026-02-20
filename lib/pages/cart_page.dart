import 'package:flutter/material.dart';
import 'package:nm_olshop/data/cart_data.dart';
import 'package:nm_olshop/pages/payment_page.dart';
import '../data/format_util.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: CartData.cartItemsNotifier,
      builder: (context, cartItems, child) {
        final grandTotal = cartItems.fold<int>(
          0,
          (sum, item) => sum + (item["price"] * item["qty"]) as int,
        );

        return Scaffold(
          appBar: AppBar(title: const Text("Cart")),
          body: cartItems.isEmpty
              ? const Center(child: Text("Keranjang kosong"))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];

                    return Card(
                      margin: const EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Image.asset(
                              product["image"] ?? "",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rp ${formatRupiah(product["price"])}",
                                    style: const TextStyle(
                                      color: Color(0xFF555555),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          CartData.decreaseQty(product);
                                        },
                                      ),
                                      Text(product["qty"].toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          CartData.increaseQty(product);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                CartData.removeFromCart(product);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

          bottomNavigationBar: cartItems.isEmpty
              ? null
              : Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 126),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                "Rp ${formatRupiah(grandTotal)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ECBC4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PaymentPage(items: CartData.cartItems),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
