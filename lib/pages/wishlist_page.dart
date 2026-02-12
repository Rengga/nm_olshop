import 'package:flutter/material.dart';
import 'package:nm_olshop/widgets/header.dart';
import 'package:nm_olshop/widgets/product_section.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(child: const ProductSection(title: 'Wishlist')),
          ],
        ),
      ),
    );
  }
}
