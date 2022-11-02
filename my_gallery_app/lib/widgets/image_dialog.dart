import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/pages/fullscreen_page.dart';

class ImageDialog extends StatelessWidget
{
  const ImageDialog({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector
    (
      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => FullscreenPage(image: image))),
      child: Dialog
      (
        backgroundColor: Colors.transparent,
        child: SizedBox
        (
          height: 500.h,
          child: ClipRRect
          (
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(image,fit: BoxFit.cover)
          ),
        ),
      ),
    );
  }
}