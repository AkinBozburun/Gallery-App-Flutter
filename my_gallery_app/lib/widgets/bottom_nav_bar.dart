import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/pages/explore_page.dart';
import 'package:my_gallery_app/pages/favs_page.dart';
import 'package:my_gallery_app/pages/search_page.dart';

class BottomNavBar extends StatefulWidget
{
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
{
  List pages =
  [
    const ExplorePage(),
    const FavsPage(),
    const SearchPage(),
  ];

  int pageNo = 0;

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold
    (
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: pages[pageNo],
      bottomNavigationBar: DotNavigationBar
      (
        onTap: (i)=> setState(()=> pageNo = i),
        currentIndex: pageNo,
        enablePaddingAnimation: false,
        dotIndicatorColor: Colors.green.shade900,
        selectedItemColor: Colors.green.shade900,
        unselectedItemColor: Colors.grey.shade600,
        marginR: orientation == Orientation.landscape?
        EdgeInsets.symmetric(horizontal:100.w,vertical: 30.h) :
        EdgeInsets.symmetric(horizontal:40.w,vertical: 5.h),
        paddingR: EdgeInsets.only(top:5.h,bottom: 5.h),
        items:
        [
          DotNavigationBarItem(icon: const Icon(Icons.explore)),
          DotNavigationBarItem(icon: const Icon(Icons.favorite_border)),
          DotNavigationBarItem(icon: const Icon(Icons.search)),
        ],
      ),
    );
  }
}