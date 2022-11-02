import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget
{
  final IconButton icon;
  const Button({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;
    return Container
    (
      height: orientation == Orientation.landscape? 100.h : 80.w,
      width: 80.w,
      decoration: BoxDecoration
      (
        borderRadius: BorderRadius.circular(10),
        color: Colors.black26
      ),
      child: icon
    );
  }
}