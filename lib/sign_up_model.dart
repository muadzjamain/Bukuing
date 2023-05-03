import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpModel extends ChangeNotifier {
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;

  String? Function(String?)? textController1Validator;
  String? Function(String?)? textController2Validator;

  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    super.dispose();
  }
}

SignUpModel createModel(BuildContext context, SignUpModel Function() builder) {
  return ChangeNotifierProvider<SignUpModel>(
    create: (_) => builder(),
    child: Consumer<SignUpModel>(
      builder: (context, model, _) => model,
    ),
  );
}