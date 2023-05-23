import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchText;

  const SearchResultsPage({super.key, required this.searchText, required List searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Center(
        child: Text('Search Results for $searchText'),
      ),
    );
  }
}
