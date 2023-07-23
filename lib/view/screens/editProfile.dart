import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tabibi/services/users.dart';
import 'package:tabibi/utils/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;
  final String userRole;

  EditProfileScreen({required this.userId, required this.userRole});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _cniController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _urgenceController = TextEditingController();
  TextEditingController _specialityController = TextEditingController();
  TextEditingController _sexeController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  File? _imageFile;
  final picker = ImagePicker();
  Future<void> _pickImage() async {
    final PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'selectImageSource'.tr,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.camera,
                      color: mainColor,
                    ),
                    title: Text('camera'.tr),
                    onTap: () {
                      Navigator.pop(context, ImageSource.camera);
                    },
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: mainColor,
                    ),
                    title: Text('gallery'.tr),
                    onTap: () {
                      Navigator.pop(context, ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (imageSource != null) {
        final pickedFile = await picker.pickImage(source: imageSource);
        if (pickedFile != null) {
          setState(() {
            _imageFile = File(pickedFile.path);
          });
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('permissionDenied'.tr),
            content: Text('grantCameraPermission'.tr),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'.tr),
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> _convertImageToBase64(File image) async {
    final bytes = await image.readAsBytes();
    final encodedImage = base64Encode(bytes);
    return encodedImage;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userRole);
    print(widget.userId);
    if (widget.userRole == "Doctor") {
      return _buildDoctorProfile();
    } else if (widget.userRole == "Patient") {
      return _buildPatientProfile();
    } else {
      return _buildDefaultProfile();
    }
  }

  Widget _buildDoctorProfile() {
    return Scaffold(
      appBar: AppBar(
        title: Text('editProfile'.tr),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: mainColor,
                    child: _imageFile != null
                        ? ClipOval(
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor,
                      ),
                      child: IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'username'.tr,
                prefixIcon: Icon(Icons.person, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'emailHint'.tr,
                prefixIcon: Icon(Icons.email, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: 'oldPassword'.tr,
                prefixIcon: Icon(Icons.password, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'newPassword'.tr,
                prefixIcon: Icon(Icons.password, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _cniController,
              decoration: InputDecoration(
                labelText: 'cni'.tr,
                prefixIcon: Icon(Icons.credit_card, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'phone'.tr,
                prefixIcon: Icon(Icons.phone, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _specialityController,
              decoration: InputDecoration(
                labelText: 'speciality'.tr,
                prefixIcon: Icon(Icons.warning, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _sexeController,
              decoration: InputDecoration(
                labelText: 'gender'.tr,
                prefixIcon: Icon(Icons.people, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'age'.tr,
                prefixIcon: Icon(Icons.calendar_today, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 22),
            ElevatedButton(
              onPressed: () async {
                if (_oldPasswordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('missingInformation'.tr),
                        content: Text('updateProfilePrompt'.tr),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'.tr),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                final userId = int.parse(widget.userId);

                final profileData = {
                  'oldPassword': _oldPasswordController.text,
                  'newPassword': _newPasswordController.text,
                  'username': _usernameController.text,
                  'email': _emailController.text,
                  'cni': _cniController.text,
                  'phone': _phoneController.text,
                  'speciality': _specialityController.text,
                  'sexe': _sexeController.text,
                  'age': _ageController.text,
                };

                String? base64Image;

                if (_imageFile != null) {
                  base64Image = await _convertImageToBase64(_imageFile!);
                }

                try {
                  await uploadProfileData(userId, profileData, base64Image);
                  Navigator.pop(context);
                } catch (e) {
                  print('updateProfileError: $e'.tr);
                  Fluttertoast.showToast(
                    msg: 'updateDataError'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 17.0,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: mainColor,
              ),
              child: Text('save'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientProfile() {
    return Scaffold(
      appBar: AppBar(
        title: Text('editProfile'.tr),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: mainColor,
                    child: _imageFile != null
                        ? ClipOval(
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor,
                      ),
                      child: IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'username'.tr,
                prefixIcon: Icon(Icons.person, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'emailHint'.tr,
                prefixIcon: Icon(Icons.email, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: 'oldPassword'.tr,
                prefixIcon: Icon(Icons.password, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'newPassword'.tr,
                prefixIcon: Icon(Icons.password, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _cniController,
              decoration: InputDecoration(
                labelText: 'cni'.tr,
                prefixIcon: Icon(Icons.credit_card, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'phone'.tr,
                prefixIcon: Icon(Icons.phone, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _urgenceController,
              decoration: InputDecoration(
                labelText: 'Emergency'.tr,
                prefixIcon: Icon(Icons.warning, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _sexeController,
              decoration: InputDecoration(
                labelText: 'gender'.tr,
                prefixIcon: Icon(Icons.people, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'age'.tr,
                prefixIcon: Icon(Icons.calendar_today, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 22),
            ElevatedButton(
              onPressed: () async {
                if (_oldPasswordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('missingInformation'.tr),
                        content: Text('updateProfilePrompt'.tr),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'.tr),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                final userId = int.parse(widget.userId);

                final profileData = {
                  'oldPassword': _oldPasswordController.text,
                  'newPassword': _newPasswordController.text,
                  'username': _usernameController.text,
                  'email': _emailController.text,
                  'cni': _cniController.text,
                  'phone': _phoneController.text,
                  'urgence': _urgenceController.text,
                  'sexe': _sexeController.text,
                  'age': _ageController.text,
                };

                String? base64Image;

                if (_imageFile != null) {
                  base64Image = await _convertImageToBase64(_imageFile!);
                }

                try {
                  await uploadProfileData(userId, profileData, base64Image);
                  Navigator.pop(context);
                } catch (e) {
                  print('updateProfileError : $e'.tr);
                  Fluttertoast.showToast(
                    msg: 'updateDataError'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 17.0,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: mainColor,
              ),
              child: Text('save'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultProfile() {
    return Scaffold(
      appBar: AppBar(
        title: Text('editProfile'.tr),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: mainColor,
                    child: _imageFile != null
                        ? ClipOval(
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor,
                      ),
                      child: IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'username'.tr,
                prefixIcon: Icon(Icons.person, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'hintEmail'.tr,
                prefixIcon: Icon(Icons.email, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: 'oldPassword'.tr,
                prefixIcon: Icon(Icons.password, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'newPassword'.tr,
                prefixIcon: Icon(Icons.password, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _cniController,
              decoration: InputDecoration(
                labelText: 'cni'.tr,
                prefixIcon: Icon(Icons.credit_card, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'phone'.tr,
                prefixIcon: Icon(Icons.phone, color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            SizedBox(height: 22),
            ElevatedButton(
              onPressed: () async {
                if (_oldPasswordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('missingInformation'.tr),
                        content: Text(
                          'updateProfilePrompt'.tr,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'.tr),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                final userId = int.parse(widget.userId);

                final profileData = {
                  'oldPassword': _oldPasswordController.text,
                  'newPassword': _newPasswordController.text,
                  'username': _usernameController.text,
                  'email': _emailController.text,
                  'cni': _cniController.text,
                  'phone': _phoneController.text,
                };

                String? base64Image;

                if (_imageFile != null) {
                  base64Image = await _convertImageToBase64(_imageFile!);
                }

                try {
                  await uploadProfileData(userId, profileData, base64Image);
                } catch (e) {
                  print('updateProfileError : $e'.tr);
                  Fluttertoast.showToast(
                    msg: 'updateDataError'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 17.0,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: mainColor,
              ),
              child: Text('save'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
