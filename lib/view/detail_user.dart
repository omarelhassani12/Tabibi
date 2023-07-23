import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibi/services/users.dart';
import 'package:tabibi/utils/theme.dart';

class UserDetailsScreen extends StatefulWidget {
  final int id;

  const UserDetailsScreen({
    required this.id,
  });

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await getUserData(widget.id.toString());
    setState(() {
      userData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("this is the id : ${widget.id}");
    return Scaffold(
      appBar: AppBar(
        title: Text('userDetails'.tr),
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(userData?['avatar'] ?? ''),
                radius: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'username'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${userData?['username'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              'emailHint'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${userData?['email'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              'cni'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${userData?['cni'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              'phone'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${userData?['phone'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              'gender'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${userData?['sexe'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              'age'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${userData?['age'] ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            if (userData?['role'] == 'Patient') ...[
              Text(
                'emergency'.tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '${userData?['urgence'] ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
            ],
            if (userData?['role'] == 'Doctor') ...[
              Text(
                'speciality'.tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '${userData?['speciality'] ?? ''}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
