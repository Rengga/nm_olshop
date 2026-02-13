import 'package:flutter/material.dart';
import 'package:nm_olshop/data/wishlist_data.dart';
import 'package:nm_olshop/widgets/header.dart';
import 'package:nm_olshop/widgets/product_section.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: ProductSection(
                title: 'Wishlist',
                customProducts: WishlistData.wishlistItems,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
