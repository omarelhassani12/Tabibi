import 'package:flutter/material.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/screens/patient/SearchResultsPage.dart';

class MyCustomSearchBar extends StatefulWidget {
  const MyCustomSearchBar({super.key});

  @override
  _MyCustomSearchBarState createState() => _MyCustomSearchBarState();
}

class _MyCustomSearchBarState extends State<MyCustomSearchBar> {
  final TextEditingController _searchQueryController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchChanged);
    _searchQueryController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchQueryController.text;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchQueryController.clear();
      _searchText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        controller: _searchQueryController,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultsPage(
                    searchText: _searchQueryController.text, 
                    searchResults: const [],
                  ),
                ),
              );
            },
            child: Icon(
              Icons.search,
              color: mainColor,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: mainColor,
            ),
            onPressed: _clearSearch,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
