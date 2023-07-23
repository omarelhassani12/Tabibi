import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/services/users.dart';
import 'package:tabibi/utils/theme.dart';
import 'dart:io';
import 'package:tabibi/view/screens/editProfile.dart';

class ProfileScreen extends StatefulWidget {
  final File? imageFile;

  const ProfileScreen({Key? key, this.imageFile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>?> userDataFuture = Future.value(null);
  Map<String, dynamic> map = {};

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final id = prefs.getInt('id') ?? 0;
      print('ID stocké : $id');
      setState(() {
        map['currentUserID'] = id.toString();
        userDataFuture = getUserData(map['currentUserID']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('error : ${snapshot.error}'.tr));
            } else if (snapshot.data == null) {
              return Center(child: Text('userDataNotFound'.tr));
            } else {
              final userData = snapshot.data!;
              final bool isPatient = userData['role'] == 'Patient';
              final bool isDoctor = userData['role'] == 'Doctor';

              return ListView(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: mainColor,
                      child: ClipOval(
                        child: Image.network(
                          userData['avatar'],
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.person, color: mainColor),
                    title: Text('username'.tr),
                    subtitle: Text(userData['username'].toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: mainColor),
                    title: Text('emailHint'.tr),
                    subtitle: Text(userData['email'].toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card, color: mainColor),
                    title: Text('cni'.tr),
                    subtitle: Text(userData['cni'].toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: mainColor),
                    title: Text('phone'.tr),
                    subtitle: Text(userData['phone'].toString()),
                  ),
                  if (isPatient)
                    ListTile(
                      leading: Icon(Icons.warning, color: mainColor),
                      title: Text('emergency'.tr),
                      subtitle: Text(userData['urgence'].toString()),
                    ),
                  if (isDoctor)
                    ListTile(
                      leading: Icon(Icons.star, color: mainColor),
                      title: Text('speciality'.tr),
                      subtitle: Text(userData['speciality'].toString()),
                    ),
                  ListTile(
                    leading: Icon(Icons.people, color: mainColor),
                    title: Text('gender'.tr),
                    subtitle: Text(userData['sexe'].toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today, color: mainColor),
                    title: Text('age'.tr),
                    subtitle: Text(userData['age'].toString()),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            userId: map['currentUserID'],
                            userRole: userData['role'],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: mainColor,
                    ),
                    child: Text('editProfile'.tr),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
