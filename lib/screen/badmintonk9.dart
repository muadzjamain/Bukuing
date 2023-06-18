import 'package:bukuing/screen/approve.dart';
import 'package:bukuing/screen/decline.dart';
import 'package:bukuing/screen/badminton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/badminton_K9_model.dart';
export '../model/badminton_K9_model.dart';

class Badmintonk9Widget extends StatefulWidget {
  const Badmintonk9Widget({Key? key}) : super(key: key);

  @override
  _BookingCourtWidgetState createState() => _BookingCourtWidgetState();
}

class _BookingCourtWidgetState extends State<Badmintonk9Widget> {
  late BadmintonK9Model _model;

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  /// booking code
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _model = BadmintonK9Model();
    _model.initState(context);

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
  }

  Future<void> _saveBookingData() async {
    // Get the values from the text controllers
    String date = textController1.text;
    String startTime = textController2.text;
    String endTime = textController3.text;

    print('1 book firestore btn pressed...');

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    print('1.5 book firestore btn pressed...');

    try {
      // Create a Firestore instance
      final firestore = FirebaseFirestore.instance;
      print('2 book firestore btn pressed...');

      // Create a new document in a 'bookings' collection and set the data
      await firestore.collection('bookings').add({
        'uid': user.uid,
        'date': date,
        'start_time': startTime,
        'end_time': endTime,
        'court': "K9",
      });

      // Show a success message to the user
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(content: Text('Booking data saved to Firebase')),
      );
    } catch (e) {
      // Show an error message to the user
      print(e);
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to save booking data')),
      );
    }
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
        backgroundColor: Color(0xFF0F151C),
        appBar: AppBar(
          backgroundColor: Color(0xFFF7D46E),
          automaticallyImplyLeading: false,
          leading: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 30,
            iconSize: 30,
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              print('IconButton pressed ...');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BadmintonPageWidget()));
            },
          ),
          title: Text(
            'Badminton',
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
          child: Stack(
            children: [
              Image.asset(
                'images/signinpage2.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'images/k9k10.jpg',
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        fit: BoxFit.cover,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 72, 0, 0),
                                            child: Text(
                                              'K9 & K10',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'Time & Date',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 200, 0),
                              child: TextFormField(
                                controller: textController1,
                                autofocus: true,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  hintText: 'Date',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                                keyboardType: TextInputType.datetime,
                                validator: (value) => _model
                                    .textController1Validator
                                    ?.call(context, value),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Time',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 13, 0),
                              child: TextFormField(
                                controller: textController2,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Start (##:##)',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                keyboardType: TextInputType.datetime,
                                validator: (value) => _model
                                    .textController1Validator
                                    ?.call(context, value),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 13, 0),
                              child: TextFormField(
                                controller: textController3,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'End (##:##)',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                keyboardType: TextInputType.datetime,
                                validator: (value) => _model
                                    .textController3Validator
                                    ?.call(context, value),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final db = FirebaseFirestore.instance;
                              final bookingRef = db
                                  .collection("bookings")
                                  .where('court', isEqualTo: 'K9');
                              final snapbooking = await bookingRef.get();
                              final exampleDB = snapbooking.docs
                                  .map((e) => e.data())
                                  .toList();

                              // Example data for the user want to book
                              final bookingDate = textController1.text;
                              final bookingStart = textController2.text;
                              final bookingEnd = textController3.text;
                              final bookingDateSplitted =
                                  bookingDate.split('/').map((d) {
                                return int.parse(d);
                              }).toList();
                              final bookingStartNumbered =
                                  int.parse(bookingStart.split(':').join(''));
                              final bookingEndNumbered =
                                  int.parse(bookingEnd.split(':').join(''));

                              final isBooked = exampleDB
                                  .map((d) {
                                    final bookedDate = d['date'];
                                    final bookedStart = d['start_time'];
                                    final bookedEnd = d['end_time'];

                                    // Check if data is null
                                    if (bookedDate == null ||
                                        bookedStart == null ||
                                        bookedEnd == null) return false;

                                    final bookedDateSplitted =
                                        bookedDate.split('/').map((d) {
                                      return int.parse(d);
                                    }).toList();
                                    final bookedStartNumbered = int.parse(
                                        bookedStart.split(':').join(''));
                                    final bookedEndNumbered = int.parse(
                                        bookedEnd.split(':').join(''));

                                    // Check the current Date
                                    if (bookedDateSplitted[0] ==
                                                bookingDateSplitted[
                                                    0] && // Check day
                                            bookedDateSplitted[1] ==
                                                bookingDateSplitted[
                                                    1] && // Check month
                                            bookedDateSplitted[2] ==
                                                bookingDateSplitted[
                                                    2] // Check year
                                        ) {
                                      // Check the current time
                                      if ((bookingStartNumbered >=
                                                  bookedStartNumbered &&
                                              bookingStartNumbered <
                                                  bookedEndNumbered) ||
                                          (bookingEndNumbered >
                                                  bookedStartNumbered &&
                                              bookingEndNumbered <=
                                                  bookedEndNumbered)) {
                                        return true;
                                      }
                                    }

                                    return false;
                                  })
                                  .toList()
                                  .contains(true);

                              if (isBooked) {
                                print('Already Booked');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DeclinePageWidget()));
                              } else {
                                print('Success Booked');
                                _saveBookingData(); // Call the save function when button is pressed
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ApprovePageWidget()));
                              }
                            },
                            child: Text(
                              'Book',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF7D46E),
                              elevation: 2,
                              padding: EdgeInsets.zero,
                              minimumSize: Size(130, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide.none,
                            ),
                          )
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
