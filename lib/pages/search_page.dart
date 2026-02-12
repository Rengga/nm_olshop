import 'package:flutter/material.dart';
import 'package:nm_olshop/widgets/search_bar.dart';
import 'package:nm_olshop/widgets/product_section.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBarWidget(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),

            Expanded(
              child: ProductSection(
                title: 'Search Results',
                searchQuery: searchQuery, // 🔥 kirim query
              ),
            ),
          ],
        ),
      ),
    );
  }
}
