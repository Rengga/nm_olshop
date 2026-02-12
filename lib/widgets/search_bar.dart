import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
