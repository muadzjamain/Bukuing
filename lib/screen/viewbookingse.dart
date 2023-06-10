import 'package:bukuing/screen/draweradmin.dart';
import 'package:bukuing/screen/homeadmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/view_booking_se_model.dart';
export '../model/view_booking_se_model.dart';

class BookingSeWidget extends StatefulWidget {
  const BookingSeWidget({Key? key}) : super(key: key);

  @override
  _BookingHistoryWidgetState createState() => _BookingHistoryWidgetState();
}

class _BookingHistoryWidgetState extends State<BookingSeWidget> {
  late BookingSeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  Map users = {};

  @override
  void initState() {
    super.initState();
    _model = BookingSeModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Future<List> _fetchBooking() async {
    // Firestore initialize
    final db = FirebaseFirestore.instance;
    final userRef = db.collection("users");
    users = await userRef.get().then((doc) {
      final User = {};
      for (var docSnapshot in doc.docs) {
        User[docSnapshot.id] = docSnapshot.data();
      }
      return User;
    }).onError((error, stackTrace) {
      print("Error getting document: $error, $stackTrace");

      return {};
    });
    // Fetch data from firestore
    final colRef = db.collection("bookings");
    final colQuery = colRef.where('court', isEqualTo: 'Kompleks');
    final data = await colQuery.get().then((doc) {
      final bookings = [];
      for (var docSnapshot in doc.docs) {
        bookings.add({'docId': docSnapshot.id, ...docSnapshot.data()});
      }
      return bookings;
    }).onError((error, stackTrace) {
      print("Error getting document: $error, $stackTrace");
      return [];
    });

    return data;
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
                  'View Booking',
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
                                'images/kompleks_sukan.jpg',
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 220, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Sport Excellences',
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                users[snapshot.data?[index]
                                                    ['uid']]['email'],
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
                                        );
                                      }),
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
            ),
          );
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }
}
