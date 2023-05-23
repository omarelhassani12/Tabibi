import 'package:flutter/material.dart';
import 'package:tabibi/utils/theme.dart';

class SubEmergencyScreen extends StatefulWidget {
  final String title;

  const SubEmergencyScreen({super.key, required this.title});
  @override
  _SubEmergencyScreenState createState() => _SubEmergencyScreenState();
}

class _SubEmergencyScreenState extends State<SubEmergencyScreen> {
  int _selectedSubEmergencyIndex = -1;
  late String _appBarTitle;

  final List<Map<String, dynamic>> _subEmergencies = [
    {
      'title': 'Bras',
      'titleImage': 'assets/urgancy/bras_title.png',
      'image': 'assets/urgancy/bras.png',
      'details':
          'Calmer la victime Placer le bras fracturé contre la poitrine et l\'entourer en écharpe avec un tissu noué derrière le cou .',
    },
    {
      'title': 'Jambe',
      'titleImage': 'assets/urgancy/jambe_title.png',
      'image': 'assets/urgancy/jambe.png',
      'details':
          'Calmer la victime Placer une attelle rigide provisoire (planchette de bois) de part et d\'autre de la jambe fracturée et maintenir le tout avec un tissu noué (ne pas serrer trop fort pour ne pas altérer la circulation sanguine).',
    },
    {
      'title': 'Cuisse',
      'titleImage': 'assets/urgancy/cuisse_title.png',
      'image': 'assets/urgancy/cuisse.png',
      'details':
          'Calmer la victime Ne pas mobiliser la cuisse, ne pas essayer de redresser, ne pas boire, ne pas manger, ne pas prendre d\'antidouleurs.  .',
    },
  ];

  @override
  void initState() {
    super.initState();
    _appBarTitle = widget.title;
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
    return InkWell(
      onTap: () => _onSubEmergencySelected(index),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          // color: Colors.white,
          // color: secondClr,
          color: mainColor,
          // color: greenClr,
          // color: Colors.black,

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
                    _subEmergencies[index]['title'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: Image.asset(
                    _subEmergencies[index]['titleImage'],
                    fit: BoxFit.cover,
                  ),
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
                      _subEmergencies[index]['details'],
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Image.asset(
                      _subEmergencies[index]['image'],
                      fit: BoxFit.cover,
                    ),
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
        title: Text(
          _appBarTitle,
          // style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,

        // backgroundColor: greenClr,
      ),
      body: ListView.builder(
        itemCount: _subEmergencies.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildSubEmergencyListItem(index);
        },
      ),
    );
  }
}








///////////////////////:
// class _SubEmergencyScreenState extends State<SubEmergencyScreen> {
//   int _selectedSubEmergencyIndex = -1;
//   late String _appBarTitle;

//   final List<Map<String, dynamic>> _subEmergencies = [
//     {
//       'title': 'Bras',
//       'image': 'assets/urgancy/bras.png',
//       'details':
//           'Calmer la victime Placer le bras fracturé contre la poitrine et l\'entourer en écharpe avec un tissu noué derrière le cou .',
//     },
//     {
//       'title': 'Jambe',
//       'image': 'assets/images/heart.png',
//       'details':
//           'Calmer la victime Placer une attelle rigide provisoire (planchette de bois) de part et d\'autre de la jambe fracturée et maintenir le tout avec un tissu noué (ne pas serrer trop fort pour ne pas altérer la circulation sanguine).',
//     },
//     {
//       'title': 'Cuisse',
//       'image': 'assets/images/heart.png',
//       'details':
//           'Calmer la victime Ne pas mobiliser la cuisse, ne pas essayer de redresser, ne pas boire, ne pas manger, ne pas prendre d\'antidouleurs.  .',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _appBarTitle = widget.title;
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

//   Widget _buildSubEmergencyListItem(int index) {
//     final bool isSelected = index == _selectedSubEmergencyIndex;
//     return InkWell(
//       onTap: () => _onSubEmergencySelected(index),
//       child: Container(
//         margin: const EdgeInsets.all(10.0),
//         padding: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           // color: secondClr,
//           // color: mainColor,
//           color: greenClr,
//           // color: Colors.black,

//           borderRadius: BorderRadius.circular(20.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 7,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     _subEmergencies[index]['title'],
//                     style: const TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 80.0,
//                   height: 80.0,
//                   child: Image.asset(
//                     _subEmergencies[index]['image'],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//             if (isSelected)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _subEmergencies[index]['details'],
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20.0,
//                     ),
//                     Image.asset(
//                       _subEmergencies[index]['image'],
//                       fit: BoxFit.cover,
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: const Text('Fracture'),
//         title: Text(_appBarTitle),
//       ),
//       body: ListView.builder(
//         itemCount: _subEmergencies.length,
//         itemBuilder: (BuildContext context, int index) {
//           return _buildSubEmergencyListItem(index);
//         },
//       ),
//     );
//   }
// }
