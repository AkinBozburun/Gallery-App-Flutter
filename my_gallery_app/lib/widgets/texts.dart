import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Color txtColor = Colors.grey.shade800;

class LabelText extends StatelessWidget
{
  final String text;

  const LabelText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;
    return Padding
    (
      padding: const EdgeInsets.only(left: 10),
      child: Text
      (
        text,
        style: GoogleFonts.notoSans(textStyle: TextStyle(color: txtColor,
        fontSize:orientation == Orientation.landscape? 14.sp : 28.sp,
        fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class TitleText extends StatelessWidget
{
  final String text;

  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;
    return Text
    (
      text,
      style: GoogleFonts.poppins(textStyle: TextStyle(color: txtColor,
      fontSize:orientation == Orientation.landscape? 16.sp : 28.sp,
      fontWeight: FontWeight.w700)),
    );
  }
}

class ResultText extends StatelessWidget
{
  final int resultCount;
  final String searchTxt;

  const ResultText({super.key, required this.resultCount, required this.searchTxt});

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;

    return RichText(text: TextSpan
    (
      style: TextStyle(color: txtColor,fontSize:orientation == Orientation.landscape? 16.sp : 28.sp),
      children:
      [
        TextSpan(text: "${resultCount.toString()} Results for ",style: GoogleFonts.nunito()),
        TextSpan(text: searchTxt,style: GoogleFonts.nunito(textStyle: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    ));
  }
}



Widget infoTxt(String txt,int fontSize) =>
Center(child: Text(txt, style: GoogleFonts.nunito(textStyle: TextStyle(color: txtColor,fontSize: fontSize.sp,fontWeight: FontWeight.w700))));

Widget categoriesTxt(String txt) =>
Text(txt,style: GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 24,color: Colors.white70,fontWeight: FontWeight.bold)));

Widget imageDiscTxt(String txt, int fontSize) =>
Text(txt,textAlign: TextAlign.center,style: GoogleFonts.dosis(textStyle: TextStyle(color: txtColor,fontSize: fontSize.sp,fontWeight: FontWeight.w500)));

Widget photographerTxt(String txt, int fontSize) =>
Text(txt, textAlign: TextAlign.center, style: GoogleFonts.nunito(textStyle: TextStyle(color: txtColor,fontSize: fontSize.sp,fontWeight: FontWeight.w800)));