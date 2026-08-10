import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({required String label, required BuildContext context, required Color backgroundColor, TextStyle? contentTextStyle}) {
  return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: backgroundColor,
            // action: SnackBarAction(
            //   label: "Error",
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
            margin: EdgeInsets.all(30),
            content: Text(label, style: contentTextStyle),
            duration: const Duration(milliseconds: 1500),
            // width: MediaQuery.sizeOf(context).width * 0.3, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );}