
import 'package:bukuing/screen/signup.dart';
import 'package:flutter/material.dart';

import '../model/starting_page2_model.dart';
export '../model/starting_page2_model.dart';

class StartingPage2Widget extends StatefulWidget {
  const StartingPage2Widget({Key? key}) : super(key: key);

  @override
  _StartingPage2WidgetState createState() => _StartingPage2WidgetState();
}

class _StartingPage2WidgetState extends State<StartingPage2Widget> {
  late StartingPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = StartingPage2Model();
    _model.initState(context);
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
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'images/startingpage2_(edited).jpg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, -0.25),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 160),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Image.asset(
                                      'images/logo-removebg-preview.png',
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0.45),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'WELCOME',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Primary Family',
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white,
                              // Add any other properties you need
                              ),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0.6),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(150, 0, 150, 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                    children: [
                      ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFF7D46E), // Button background color
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Button border radius
                              ),
                              elevation: 0, // Button elevation
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0, // Button text font size
                                color: Colors.black, // Button text color
                              ),
                            ),
                          ),

                      ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpWidget()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFF7D46E), // Button background color
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Button border radius
                              ),
                              elevation: 0, // Button elevation
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0, // Button text font size
                                color: Colors.black, // Button text color
                              ),
                            ),
                          ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
