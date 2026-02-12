import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {

  VoidCallback? onTap;
  String title;
  Color bgColor;
  bool isIcon;
  IconData? mIcon;
  double mWidth;
  Color fgColor;
  Widget? myChild;

  AppRoundedButton({
    super.key,
    required this.onTap,
    required this.title,
    this.bgColor = Colors.amber,
    this.fgColor = Colors.white,
    this.isIcon = false,
    this.mIcon,
    this.mWidth = double.infinity,
    this.myChild
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
        ),
        onPressed: onTap,
        child: myChild ?? (isIcon ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(mIcon), SizedBox(height: 11)],
              ) : Text(title))),
    );
  }
}
