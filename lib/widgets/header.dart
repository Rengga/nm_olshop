import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMessageTap;

  const Header({super.key, this.onNotificationTap, this.onMessageTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'MOONDROP',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Row(
            children: [
              _HeaderIcon(
                icon: Icons.notifications_none,
                onTap: onNotificationTap,
              ),
              const SizedBox(width: 12),
              _HeaderIcon(icon: Icons.message_outlined, onTap: onMessageTap),
            ],
          ),
        ],
      ),
    );
  }
}

//
// ================= HEADER ICON =================
//
class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeaderIcon({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }
}
