import 'package:flutter/material.dart';
import 'package:nm_olshop/pages/search_page.dart';
import 'package:nm_olshop/widgets/header.dart';
import 'package:nm_olshop/widgets/product_section.dart';
import 'package:nm_olshop/widgets/search_bar.dart';
// import 'package:nm_olshop/widgets/bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const double _bottomNavHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Stack(
          children: [
            // ================= CONTENT =================
            Padding(
              // 👇 biar grid gak ketutup bottom nav
              padding: const EdgeInsets.only(bottom: _bottomNavHeight),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Header(),

                          const SizedBox(height: 16),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SearchBarWidget(
                              readOnly: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SearchPage(),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 16),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _banner(),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ];
                },
                body: const ProductSection(title: 'Product'),
              ),
            ),

            // ================= FLOATING BOTTOM NAV =================
            // Positioned(left: 10, right: 10, bottom: 10, child: _bottomNav()),
          ],
        ),
      ),
    );
  }

  // ================= BANNER =================
  Widget _banner() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
