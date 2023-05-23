// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tabibi/utils/theme.dart';

//logo and name with cni
class AppNameArrowBack extends StatelessWidget {
  final String pageTitle;
  const AppNameArrowBack({Key? key, required this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: mainColor,
            ),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          title: Text(
            pageTitle,
            style: TextStyle(
              color: mainColor,
            ),
          ),
        ),
        body: SizedBox(
          height: 400, // Set a finite height for the SizedBox
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 16.0,
                right: 16.0,
                child: Card(
                  color: Colors.white,
                  elevation: 0.75,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Name: HASSAN',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'CNI: HH3456789',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
