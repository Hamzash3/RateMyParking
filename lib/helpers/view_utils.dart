
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewUtils {
  static List<String> dateFormat = ["yyyy", '-', "mm", '-', "dd"];

  static String baseUrl = 'http://ratemyparking.cheapsst.com';


  static String licenceNumberRoute = "/licence";
  static String homeRoute= "/home";
  static String postDetailRoute= "/post_details";
  static String loginRoute= "/login";
  static String signUpRoute= "/signUp";
  static String addPostRoute= "/addPost";

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  String getNullableString(String? value) {
    if (value != null) {
      return value;
    }
    return "";
  }

  double getNullableDouble(double? value) {
    if (value != null) {
      return value;
    }
    return 0.0;
  }

  String getNullableFileUrl(String? value) {
    if (value != null) {
      return "$baseUrl$value";
    }
    return "";
  }


  static BuildContext? progressDialogContext;

  showProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          progressDialogContext = context;
          return AlertDialog(
            content: Row(
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  width: 25,
                ),
                Text("Please Wait...")
              ],
            ),
          );
        });
  }

  dismissProgressDialog() {
    if (progressDialogContext != null) {
      Navigator.pop(progressDialogContext!);
    }
  }
}

extension HexColor on Color {
  static Color fromHex(String? hexString) {
    if (hexString != null) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } else {
      return Colors.blue;
    }
  }
}
