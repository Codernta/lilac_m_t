import 'package:flutter/material.dart';
import 'package:lilac_mt/utilities/text_styles.dart';

class CustomWidgets {
  static showSnackBar(String s, BuildContext context) {
    debugPrint(s);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          s,
          maxLines: 2,
          style: TextStyle(fontFamily: 'Comfortaa',color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  static Widget stoppedAnimationProgress({color}) => CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
      );

  static Widget submitButton(String title,
      {void Function()? onTap, Color? bgColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: bgColor == null? Colors.blue.shade900: Colors.grey),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Comfortaa',
                  color: bgColor == null? Colors.white: Colors.blue.shade900
            ),
          ),
        ),
      ),
    );
  }
}
