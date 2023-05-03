import 'package:bukuing/screen/signin.dart';
import 'package:bukuing/screen/signup.dart';
import 'package:flutter/material.dart';


import '../model/forgot_pass_model.dart';
export '../model/forgot_pass_model.dart';

class ForgotPassWidget extends StatefulWidget {
  const ForgotPassWidget({Key? key}) : super(key: key);

  @override
  _ForgotPassWidgetState createState() => _ForgotPassWidgetState();
}

class _ForgotPassWidgetState extends State<ForgotPassWidget> {
  late ForgotPassModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = ForgotPassModel();
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/signuppage2_(edited).jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  fit: BoxFit.cover,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Image.asset(
                        'assets/images/logo-removebg-preview.png',
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 30, 20, 0),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Color(0xAEFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: Colors.black,
                                          size: 60,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          'Trouble logging in ?',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),

                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 0),
                                        child: Text(
                                          'We\'ll send you a link to get back into your account',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          child: Text('Sent login code',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Color(0xFFF7D46E)),
                                            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(0, 0, 0, 0)),
                                            minimumSize: MaterialStateProperty.all(Size(180, 50)),
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            )),
                                            side: MaterialStateProperty.all(BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            )),
                                          ),
                                        ),

                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print('Button pressed ...');
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpWidget()));
                                          },
                                          child: Text(
                                            'Create an account',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(0, 0, 0, 0)),
                                            minimumSize: MaterialStateProperty.all(Size(180, 50)),
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            )),
                                            side: MaterialStateProperty.all(BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            )),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
