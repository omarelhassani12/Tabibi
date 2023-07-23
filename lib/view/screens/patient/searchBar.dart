import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/utils/utils.dart';
import 'package:tabibi/view/screens/patient/SearchResultsPage.dart';

class MyCustomSearchBar extends StatefulWidget {
  const MyCustomSearchBar({Key? key}) : super(key: key);

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

  Future<List<dynamic>> fetchDoctorsSearch(String query) async {
    final response = await http.get(Uri.parse('${Utils.baseUrl}/doctors'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['success'] == true && jsonData['users'] is List) {
        List<dynamic> fetchedDoctors = jsonData['users'];
        List<dynamic> filteredDoctors = fetchedDoctors.where((doctor) {
          final doctorName = doctor['username'] as String?;
          final specialty = doctor['speciality'] as String?;

          return doctorName?.toLowerCase().contains(query.toLowerCase()) ==
                  true ||
              specialty?.toLowerCase().contains(query.toLowerCase()) == true;
        }).toList();

        print(filteredDoctors);
        return filteredDoctors;
      } else {
        throw Exception('Invalid response: doctors data is not a list');
      }
    } else {
      throw Exception(
          'Failed to fetch doctors. Status code: ${response.statusCode}');
    }
  }

  void _searchDoctors() async {
    if (_searchText.trim().isNotEmpty) {
      try {
        List<dynamic> searchResults = await fetchDoctorsSearch(_searchText);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultsPage(
              searchText: _searchText,
              searchResults: searchResults,
            ),
          ),
        );
      } catch (e) {
        print('Error searching doctors: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 3,
            blurRadius: 20,
          ),
        ],
      ),
      child: TextField(
        controller: _searchQueryController,
        onSubmitted: (_) {
          _searchDoctors();
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: GestureDetector(
            onTap: _searchDoctors,
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
