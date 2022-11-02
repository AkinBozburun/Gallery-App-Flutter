import 'package:flutter/material.dart';
import 'package:my_gallery_app/widgets/categories_list.dart';
import 'package:my_gallery_app/widgets/colors_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/widgets/texts.dart';

class CategoriesBody extends StatelessWidget
{
  const CategoriesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView
    (
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          SizedBox(height: 15.h),
          const LabelText(text: "Colors"),
          SizedBox(height: 10.h),
          ColorsList(),
          SizedBox(height: 35.h),
          const LabelText(text: "Categories"),
          SizedBox(height: 10.h),
          Categories(),
        ],
      ),
    );
  }
}