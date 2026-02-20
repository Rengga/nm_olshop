import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nm_olshop/data/banner_data.dart';
import 'package:nm_olshop/pages/search_page.dart';
import 'package:nm_olshop/widgets/header.dart';
import 'package:nm_olshop/widgets/product_section.dart';
import 'package:nm_olshop/widgets/search_bar.dart';
// import 'package:nm_olshop/widgets/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const double _bottomNavHeight = 0;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int currentIndex = 1;
  Timer? _timer;

  List<Map<String, dynamic>> get bannerList {
    final original = BannerData.banners;
    return [
      original.last, // dummy first
      ...original,
      original.first, // dummy last
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      currentIndex++;
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: HomePage._bottomNavHeight),
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
                            padding: const EdgeInsets.symmetric(horizontal: 0),
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

  Widget _banner() {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: bannerList.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
              // Looping logic
              if (index == 0) {
                Future.delayed(const Duration(milliseconds: 350), () {
                  _pageController.jumpToPage(bannerList.length - 2);
                  setState(() {
                    currentIndex = bannerList.length - 2;
                  });
                });
              } else if (index == bannerList.length - 1) {
                Future.delayed(const Duration(milliseconds: 350), () {
                  _pageController.jumpToPage(1);
                  setState(() {
                    currentIndex = 1;
                  });
                });
              }
            },
            itemBuilder: (context, index) {
              final banner = bannerList[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    banner["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: Colors.grey.shade300),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            BannerData.banners.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: (currentIndex - 1) == i ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: (currentIndex - 1) == i
                    ? const Color(0xFF4ECBC4)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
