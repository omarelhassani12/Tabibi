import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/services/sub-urgance.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:tabibi/view/screens/config/searchBar.dart';
import 'package:tabibi/view/screens/patient/sub_urgancy_detail_screen.dart';

class DetailUrgence extends StatefulWidget {
  const DetailUrgence({Key? key}) : super(key: key);

  @override
  State<DetailUrgence> createState() => _DetailUrgenceState();
}

class _DetailUrgenceState extends State<DetailUrgence> {
  List<dynamic> subUrgances = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubUrgances(Get.arguments).then((data) {
      setState(() {
        subUrgances = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });

    // Simulating a loading state for 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final urganceId = Get.arguments;
    print(urganceId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details d\'urgence',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: mainColor,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Trouvez vos sous-types d\'urgence ici',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    child: MyCustomSearchBar(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Sous-types',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : subUrgances.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'No sub-urgances available',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: subUrgances.length,
                                  itemBuilder: (context, index) {
                                    final subUrgance = subUrgances[index];

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubEmergencyScreen(
                                                  title: subUrgance['name'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipOval(
                                            child: SizedBox(
                                              width: 90,
                                              height: 80,
                                              child: Image.network(
                                                subUrgance['image'],
                                                height: 70,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Expanded(
                                          child: SizedBox(
                                            height: 90,
                                            width: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SubEmergencyScreen(
                                                          title: subUrgance[
                                                              'name'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                      mainColor,
                                                    ),
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all<Size>(
                                                      const Size(150, 50),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    subUrgance['name'],
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
