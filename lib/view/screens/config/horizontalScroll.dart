import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/routes/routes.dart';
import 'package:tabibi/services/urgance.dart';
import 'package:tabibi/utils/theme.dart';

// horizontal scroll

class HorizontalScroll extends StatefulWidget {
  const HorizontalScroll({Key? key}) : super(key: key);

  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  List<dynamic> urgances = [];
  bool isLoading = true; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    getUrgancesData();
  }

  void getUrgancesData() {
    fetchUrgances().then((data) {
      setState(() {
        urgances = data;
        isLoading = false; // Set loading state to false when data is fetched
      });
    }).catchError((error) {
      print('Error: $error');
      setState(() {
        isLoading = false; // Set loading state to false in case of error
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 170,
              child: isLoading // Check loading state
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: urgances.length,
                      itemBuilder: (context, index) {
                        final urgance = urgances[index];
                        return Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.detialUrgance,
                                  arguments: urgance['id']);
                            },
                            child: Container(
                              width: 120,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: secondClr,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    urgance['image'],
                                    width: 80,
                                    height: 90,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    urgance['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
