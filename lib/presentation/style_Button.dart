import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {

  CustomButton({
   required this.title,
   required this.onPressed,
    this.height =50,
    this.width =50,
    this.elevation = 1,
    this.borderRadius = 24,
    this.color =Colors.blue,
     this.textStyle,
    this.icon,
    this.hasIcon = false,
  }) : assert((hasIcon == true && icon != null) ||
      (hasIcon == false && icon == null));

  final VoidCallback? onPressed;
  final double height;
  final double width;
  final double elevation;
  final double borderRadius;
  final String? title;
  final Color color;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(width: 0, style: BorderStyle.none)
        ,
      ),

      height: height,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          hasIcon ? icon! : Container(),
          hasIcon ? SizedBox(width: 8) : Container(),
          title != null
              ? Text(
            title!,
            style: textStyle,
          )
              : Container(),
        ],
      ),
    );
  }
}