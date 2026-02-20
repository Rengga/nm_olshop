import 'package:flutter/material.dart';
import 'package:nm_olshop/data/cart_data.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home,
            label: 'Home',
            index: 0,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.favorite_border,
            label: 'Wishlist',
            index: 1,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.shopping_cart_outlined,
            label: 'Cart',
            index: 2,
            currentIndex: currentIndex,
            onTap: onTap,
            showBadge: true, // custom prop for badge
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            index: 3,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;
  final bool showBadge;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == currentIndex;
    if (showBadge) {
      // Gunakan ValueListenableBuilder agar badge update otomatis
      return ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: CartData.cartItemsNotifier,
        builder: (context, cartItems, child) {
          int cartCount = cartItems.fold<int>(
            0,
            (sum, item) => sum + (item['qty'] ?? 1) as int,
          );
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => onTap(index),
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          icon,
                          color: isActive ? Colors.white : Colors.grey,
                        ),
                        if (cartCount > 0)
                          Positioned(
                            right: -8,
                            top: -8,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '$cartCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => onTap(index),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isActive ? Colors.white : Colors.grey),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
