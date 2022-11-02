import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullscreenPage extends StatelessWidget
{
  final String image;

  const FullscreenPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector
  (
    onTap:() =>  Navigator.pop(context),
    child: Image.network
    (
      image,fit: BoxFit.cover,height: ScreenUtil().screenHeight,width:ScreenUtil().screenWidth,
    ),
  );
}