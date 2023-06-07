import 'dart:typed_data';

import 'package:bukuing/screen/draweradmin.dart';
import 'package:bukuing/screen/homeadmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../model/profile_model.dart';
export '../model/profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;
  String imageUrl = 'https://i.imgur.com/g9070k1.jpg';
  String userEmail = 'awie666@gmail.com';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = ProfileModel();
    _model.initState(context);
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    imageUrl = user.photoURL ?? imageUrl;
    userEmail = user.email ?? userEmail;
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xFFF7D46E),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Theme.of(context).textTheme.bodyText1?.color,
              size: 30,
            ),
            onPressed: () {
              print('IconButton pressed ...');
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/signinpage2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'images/anime-cityscape-landscape-scenery-4k_1541975011.jpg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          print('Open file dialog to select picture');
// Get current logged in user
                          var user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            print(
                                'User not logged in or user session is invalid');
                            return;
                          }

                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png', 'jpeg'],
                          );

                          if (result != null) {
                            late File file;
                            try {
                              if (result.files.single.path != null) {
                                file = File(result.files.single.path!);
                              }
                            } catch (_) {}
                            Uint8List fileBytes = result.files.first.bytes!;
                            //String fileName = result.files.first.name;
                            String fileExtension =
                                result.files.first.extension!;

                            // Upload image to firebase storage
                            // Upload file
                            var ref = FirebaseStorage.instance.ref(
                                '/users/${user.uid}/${user.uid}.$fileExtension');
                            var fbs = await ref.putData(fileBytes);
                            var fbsDownloadUrl = await fbs.ref.getDownloadURL();

                            // Update user profile in firebase auth
                            await user.updatePhotoURL(fbsDownloadUrl);

                            setState(() {
                              imageUrl = fbsDownloadUrl;
                            });
                          } else {
                            // User canceled the picker
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0x0057636C),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide.none,
                          minimumSize: Size(130, 40),
                        ),
                        child: Text(
                          'Edit profile picture',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 270, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Email          :',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              userEmail,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Contact      :',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              '0123456789',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
