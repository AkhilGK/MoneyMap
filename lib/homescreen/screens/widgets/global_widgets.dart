import 'package:flutter/material.dart';

class G {
  //A custome text widget
  Widget textOfMap({
    required String text,
    required double size,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  Widget sBox({required double h}) {
    return SizedBox(
      height: h,
    );
  }
}
