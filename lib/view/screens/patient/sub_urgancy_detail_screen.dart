import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/services/response.dart';
import 'package:tabibi/utils/theme.dart';

class SubEmergencyScreen extends StatefulWidget {
  final String title;
  final int id;
  final int urganceId;

  const SubEmergencyScreen({
    Key? key,
    required this.title,
    required this.id,
    required this.urganceId,
  }) : super(key: key);

  @override
  _SubEmergencyScreenState createState() => _SubEmergencyScreenState();
}

class _SubEmergencyScreenState extends State<SubEmergencyScreen> {
  int _selectedSubEmergencyIndex = -1;
  late String _appBarTitle;
  late List<Map<String, dynamic>> _responseData = [];

  @override
  void initState() {
    super.initState();
    _appBarTitle = widget.title;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await fetchResponseData(widget.id.toString());
      setState(() {
        _responseData = response.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onSubEmergencySelected(int index) {
    setState(() {
      if (_selectedSubEmergencyIndex == index) {
        _selectedSubEmergencyIndex = -1;
      } else {
        _selectedSubEmergencyIndex = index;
      }
    });
  }

  Widget _buildSubEmergencyListItem(int index) {
    final bool isSelected = index == _selectedSubEmergencyIndex;
    final Map<String, dynamic> responseData = _responseData[index];

    final String title = responseData['title'] ?? 'titleNotAvailable'.tr;
    final String? titleImage = responseData['image_title'];
    final String details =
        responseData['description'] ?? 'detailsNotAvailable'.tr;
    final String? image = responseData['desc_image'];

    final Widget titleImageWidget = titleImage != null && titleImage.isNotEmpty
        ? Image.network(
            titleImage,
            fit: BoxFit.cover,
          )
        : Container();

    final Widget detailsImageWidget = image != null && image.isNotEmpty
        ? Image.network(
            image,
            fit: BoxFit.cover,
          )
        : Container();

    return InkWell(
      onTap: () => _onSubEmergencySelected(index),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: titleImageWidget,
                ),
              ],
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    detailsImageWidget,
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: Text(
          _appBarTitle,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _responseData.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildSubEmergencyListItem(index);
        },
      ),
    );
  }
}









// class SubEmergencyScreen extends StatefulWidget {
//   final String title;
//   final int id;
//   final int urganceId;

//   const SubEmergencyScreen({
//     Key? key,
//     required this.title,
//     required this.id,
//     required this.urganceId,
//   }) : super(key: key);

//   @override
//   _SubEmergencyScreenState createState() => _SubEmergencyScreenState();
// }

// class _SubEmergencyScreenState extends State<SubEmergencyScreen> {
//   int _selectedSubEmergencyIndex = -1;
//   late String _appBarTitle;
//   late List<Map<String, dynamic>> _responseData = [];

//   @override
//   void initState() {
//     super.initState();
//     _appBarTitle = widget.title;
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final response = await fetchResponseData(widget.id.toString());
//       setState(() {
//         _responseData = response.cast<Map<String, dynamic>>();
//       });
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   void _onSubEmergencySelected(int index) {
//     setState(() {
//       if (_selectedSubEmergencyIndex == index) {
//         _selectedSubEmergencyIndex = -1;
//       } else {
//         _selectedSubEmergencyIndex = index;
//       }
//     });
//   }

//   Future<int?> getUserIdFromSharedPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? userId = prefs.getInt('id');
//     return userId;
//   }

//   Future<bool> _showExitDialog() async {
//     int? userId = await getUserIdFromSharedPrefs();

//     var response = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Question'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('La description de la réponse était-elle satisfaisante ?'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 if (userId != null) {
//                   await insertPatientHistorique(
//                     userId,
//                     widget.urganceId.toString(),
//                     DateTime.now(),
//                   );
//                 }
//                 Navigator.of(context).pop(true);
//               },
//               child: Text('Non'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (userId != null) {
//                   await insertPatientHistorique(
//                     userId,
//                     widget.urganceId.toString(),
//                     DateTime.now(),
//                   );
//                 }
//                 Navigator.of(context).pop(true);
//               },
//               child: Text('Oui'),
//             ),
//           ],
//         );
//       },
//     );

//     if (response == true) {
//       Fluttertoast.showToast(
//         msg: 'Merci pour votre réponse !',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey[600],
//         textColor: Colors.white,
//       );
//     }

//     return true;
//   }

//   Widget _buildSubEmergencyListItem(int index) {
//     final bool isSelected = index == _selectedSubEmergencyIndex;
//     final Map<String, dynamic> responseData = _responseData[index];

//     final String title = responseData['title'] ?? 'titleNotAvailable'.tr;
//     final String? titleImage = responseData['image_title'];
//     final String details =
//         responseData['description'] ?? 'detailsNotAvailable'.tr;
//     final String? image = responseData['desc_image'];

//     final Widget titleImageWidget = titleImage != null && titleImage.isNotEmpty
//         ? Image.network(
//             titleImage,
//             fit: BoxFit.cover,
//           )
//         : Container();

//     final Widget detailsImageWidget = image != null && image.isNotEmpty
//         ? Image.network(
//             image,
//             fit: BoxFit.cover,
//           )
//         : Container();

//     return InkWell(
//       onTap: () => _onSubEmergencySelected(index),
//       child: WillPopScope(
//         onWillPop: _showExitDialog,
//         child: Container(
//           margin: const EdgeInsets.all(10.0),
//           padding: const EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//             color: mainColor,
//             borderRadius: BorderRadius.circular(20.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 80.0,
//                     height: 80.0,
//                     child: titleImageWidget,
//                   ),
//                 ],
//               ),
//               if (isSelected)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         details,
//                         style: const TextStyle(
//                           fontSize: 16.0,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20.0,
//                       ),
//                       detailsImageWidget,
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mainColor,
//         elevation: 0,
//         title: Text(
//           _appBarTitle,
//         ),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: _responseData.length,
//         itemBuilder: (BuildContext context, int index) {
//           return _buildSubEmergencyListItem(index);
//         },
//       ),
//     );
//   }
// }














