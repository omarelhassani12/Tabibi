import 'package:flutter/material.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/screens/patient/main_screen_patient.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchText;
  final List<dynamic> searchResults;

  const SearchResultsPage({
    Key? key,
    required this.searchText,
    required this.searchResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildSearchResults() {
      if (searchResults.isEmpty) {
        return Center(
          child: Text('No results found.'),
        );
      } else {
        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final doctorData = searchResults[index];
            final doctorAvatar = doctorData['avatar'] as String?;
            final doctorName = doctorData['username'] as String?;
            final specialty = doctorData['speciality'] as String?;
            final id = doctorData['id'] as int?;

            return DoctorCard(
              imagePath: doctorAvatar ?? '',
              doctorName: doctorName ?? '',
              specialty: specialty ?? '',
              onViewDetailsPressed: () async {},
              id: id ?? 0,
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results: $searchText'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
      ),
      body: _buildSearchResults(),
    );
  }
}
