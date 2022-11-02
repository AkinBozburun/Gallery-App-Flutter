import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../model/fav_model.dart';

Widget loadingIndicator() =>
Center(child: CircularProgressIndicator(color:  Colors.grey.shade800));

Widget shimmerEffect(double h,double w) => Shimmer.fromColors
(
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade200,
  child: Container
  (
    height: h,width: w,
    decoration: BoxDecoration
    (
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
  ),
);

openbox() async
{
  if(!Hive.isBoxOpen("favs"))
  {
    await Hive.openBox<Favs>("favs");
    print("box açıldı");
  }
  else
  {
    print("zaten açık");
  }
}

closeBox()
{
  if(Hive.isBoxOpen("favs"))
  {
    Hive.box<Favs>("favs").close();
    print("box kapandı");
  }
  else
  {
    print("zaten kapalı");
  }
}