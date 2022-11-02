import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery_app/providers.dart';
import 'package:my_gallery_app/widgets/texts.dart';
import 'package:provider/provider.dart';


class Categories extends StatelessWidget
{
  Categories({Key? key}) : super(key: key);

  List categorieList =
  [
    {
      "name": "Art",
      "photo" : "images/art.jpg",
    },
    {
      "name": "Sky",
      "photo" : "images/sky.jpg",
    },
    {
      "name": "Cars",
      "photo" : "images/cars.jpg",
    },
    {
      "name": "City",
      "photo" : "images/city.jpg",
    },
    {
      "name": "Summer",
      "photo" : "images/summer.jpg",
    },
    {
      "name": "Space",
      "photo" : "images/space.jpg",
    },
    {
      "name": "Animals",
      "photo" : "images/animals.jpg",
    },
    {
      "name": "Nature",
      "photo" : "images/nature.jpg",
    },
    {
      "name": "Foods",
      "photo" : "images/foods.jpg",
    },
    {
      "name": "House",
      "photo" : "images/house.jpg",
    },
    {
      "name": "Sea",
      "photo" : "images/sea.jpg",
    },
    {
      "name": "Tech",
      "photo" : "images/technology.jpg",
    },
  ];

  @override
  Widget build(BuildContext context)
  {
    final borderRadius = BorderRadius.circular(10);
    final prov = Provider.of<ImageProviders>(context);
    final orientation = MediaQuery.of(context).orientation;

    return GridView.builder
    (
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
      (
        crossAxisCount: orientation == Orientation.landscape? 6: 3,
        mainAxisSpacing: 5,
        childAspectRatio: orientation == Orientation.landscape? 1: 3/4,
        crossAxisSpacing: 5,
      ),
      padding: EdgeInsets.only(bottom: orientation == Orientation.landscape? 140.h:100.h,left: 10,right: 10),
      itemCount: categorieList.length,
      itemBuilder: (_,i) => GestureDetector
      (
        onTap: () async
        {
          prov.searchImagesList = [];
          prov.searchResultTxt = categorieList[i]["name"];
          await prov.searchImage(categorieList[i]["name"]);
          prov.resultView();
        },
        child: Stack
        (
          alignment: Alignment.center,
          children:
          [
            ClipRRect
            (
              borderRadius: borderRadius,
              child: Image.asset(categorieList[i]["photo"],height: 250.h,width: 250.h,fit: BoxFit.cover),
            ),
            Container
            (
              height: 250.h, width: 250.h,
              decoration: BoxDecoration(borderRadius: borderRadius,color: Colors.black38),
            ),
            categoriesTxt(categorieList[i]["name"])
          ],
        ),
      )
    );
  }
}