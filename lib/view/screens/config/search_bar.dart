import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _searchController.clear();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.clear),
            ),
          ),
        ],
      ),
    );
  }
}
