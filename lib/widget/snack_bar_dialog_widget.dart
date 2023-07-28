import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future snackBarDialogWidget(String text) async {
  ScaffoldMessenger.of(Get.context!)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
