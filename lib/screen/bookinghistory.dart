import 'dart:async';

import 'package:bukuing/screen/appdrawer.dart';
import 'package:bukuing/screen/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/booking_history_model.dart';
export '../model/booking_history_model.dart';

class BookingHistoryWidget extends StatefulWidget {
  const BookingHistoryWidget({Key? key}) : super(key: key);

  @override
  _BookingHistoryWidgetState createState() => _BookingHistoryWidgetState();
}

class _BookingHistoryWidgetState extends State<BookingHistoryWidget> {
  late BookingHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  String profilePicture = "https://i.imgur.com/g9070k1.jpg";

  @override
  void initState() {
    super.initState();
    _model = BookingHistoryModel();
    _model.initState(context);
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    profilePicture = user.photoURL ?? profilePicture;
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Future<List> _fetchBooking() async {
    // Get current logged in user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    // Firestore initialize
    final db = FirebaseFirestore.instance;

// Fetch data from firestore
    final colRef = db.collection("bookings");
    final data = await colRef.get().then((doc) {
      final bookings = {};
      for (var docSnapshot in doc.docs) {
        bookings[docSnapshot.id] = docSnapshot.data();
      }
      return bookings;
    }).onError((error, stackTrace) {
      print("Error getting document: $error, $stackTrace");
      return {};
    });
// Check if data exists
    if (data == null) return [];

// else filter data to use current user id; ( return filtered; )
    List bookings = data.values.where((element) {
      Map booking = element as Map;
      if (booking['uid'] == user.uid) {
        return true;
      }
      return false;
    }).toList();

    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchBooking(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                    'Booking History',
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
                body: SafeArea(
                  child: Container(
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
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
                                  profilePicture,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 220, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Recent',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 10, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Badminton',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '(Sport Excellence)',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      snapshot.data?[index]
                                                          ['date'],
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      '(' +
                                                          snapshot.data?[index]
                                                              ['start_time'] +
                                                          ')',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FontStyle.normal,
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
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const LinearProgressIndicator();
          }
        });
  }
}
