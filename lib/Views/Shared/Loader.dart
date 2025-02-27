import 'package:flutter/material.dart';
import '../../Models/Constants.dart';


class Loader extends StatelessWidget {
  final bool showText;

  const Loader({Key? key, this.showText = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: appDesign.colorAccent,
        ),
        SizedBox(height: 16),
        if (showText)
          Text(
            "جاري التحميل",
            style: TextStyle(color: appDesign.colorAccent),
          ),
      ],
    );
  }
}