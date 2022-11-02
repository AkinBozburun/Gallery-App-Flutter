import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_gallery_app/model/fav_model.dart';
import 'package:my_gallery_app/pages/fullscreen_page.dart';
import 'package:my_gallery_app/widgets/down_fav_buttons.dart';
import 'package:my_gallery_app/widgets/download_file.dart';
import 'package:my_gallery_app/widgets/texts.dart';

import '../widgets/_widgets.dart';

class DetailedImagePage extends StatefulWidget
{
  final Map? gelenImageInfo;

  final String? hiveFavImage;
  final String? hiveOriginalImage;
  final String? hiveInfo;
  final String? hivePhotographer;
  final int? hivePhotoID;

  const DetailedImagePage({super.key, required this.gelenImageInfo, required this.hiveFavImage, required this.hiveOriginalImage, required this.hiveInfo, required this.hivePhotographer, required this.hivePhotoID});

  @override
  State<DetailedImagePage> createState() => _DetailedImagePageState();
}

class _DetailedImagePageState extends State<DetailedImagePage>
{
  late String favImage;
  late String originalImage;
  late String alt;
  late String photographer;
  late int photoID;

  @override
  void initState()
  {
    openbox();
    favImage = widget.gelenImageInfo?["src"]["large2x"] ?? widget.hiveFavImage;
    originalImage = widget.gelenImageInfo?["src"]["original"] ?? widget.hiveOriginalImage;
    alt = widget.gelenImageInfo?["alt"] == "" ? "No caption photo" : widget.gelenImageInfo?["alt"] ?? widget.hiveInfo;
    photographer = widget.gelenImageInfo?["photographer"] ?? widget.hivePhotographer;
    photoID = widget.gelenImageInfo?["id"] ?? widget.hivePhotoID;

    print(originalImage);
    super.initState();
  }

  @override
  void dispose()
  {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    closeBox();
    super.dispose();
  }

  _image()
  {
    return GestureDetector
    (
      onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) =>
      FullscreenPage(image: favImage))),
      child: Container
      (
        decoration: BoxDecoration
        (
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: NetworkImage(favImage),fit: BoxFit.cover),
        ),
      )
    );
  }

  _addList()
  {
    final box = Hive.box<Favs>("favs");

    final favs = Favs()
    ..favID = photoID
    ..favName = photographer
    ..favInfo = alt
    ..favImage = favImage
    ..favImageOriginal = originalImage;

    if(!box.containsKey(photoID))
    {
      box.put(photoID, favs);
      _snack("Added to Favorites!");
    }
    else
    {
      _snack("Already Added!");
    }
  }

  _snack(String text) => ScaffoldMessenger.of(context).showSnackBar
  (
    SnackBar
    (
      content: Text(text),
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 500),
    )
  );

  _buttonsRow()
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
      [
        Button
        (
          icon: IconButton(onPressed:()
          {
            _addList();
          },
          icon: const Icon
          (
            Icons.favorite,
            color: Colors.white
          )),
        ),
        Button
        (
          icon: IconButton(onPressed: ()
          {
            _snack("Downloading...");
            openFile(url: originalImage);
          },
          icon: const Icon(Icons.download_rounded,color: Colors.white)),
        ),
      ],
    );
  }

  _portraitBody()
  {
    return SafeArea
    (
      child: Padding
      (
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Column
            (
              children:
              [
                SizedBox
                (
                  height: 600.h,
                  child: _image()
                ),
                SizedBox(height: 30.h),
                imageDiscTxt(alt, 24),
                photographerTxt(photographer, 26)
              ],
            ),
            _buttonsRow(),
          ],
        ),
      ),
    );
  }

  _landscapeBody()
  {
    return SafeArea
    (
      child: Row
      (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
        [
          SizedBox
          (
            height: 300,
            width: 300.w,
            child: _image(),
          ),
          SizedBox
          (
            width: 250,
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                imageDiscTxt(alt, 12),
                SizedBox(height: 40.h),
                photographerTxt(photographer, 16),
                SizedBox(height: 100.h),
                Padding
                (
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buttonsRow()
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold
    (
      body: orientation == Orientation.landscape? _landscapeBody() : _portraitBody(),
    );
  }
}