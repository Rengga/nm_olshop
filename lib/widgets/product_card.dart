import 'package:flutter/material.dart';
import '../data/format_util.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;

  const ProductCard({Key? key, required this.name, required this.price})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(name),
          Text(
            "Rp ${formatRupiah(price)}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
