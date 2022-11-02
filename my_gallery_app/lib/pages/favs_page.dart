import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_gallery_app/pages/detailed_image_page.dart';
import 'package:my_gallery_app/providers.dart';
import 'package:my_gallery_app/widgets/_widgets.dart';
import 'package:my_gallery_app/widgets/texts.dart';
import 'package:provider/provider.dart';

class FavsPage extends StatefulWidget
{
  const FavsPage({Key? key}) : super(key: key);

  @override
  State<FavsPage> createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage>
{
  @override
  void initState()
  {
    if(!Hive.isBoxOpen("favs"))
    {
      Provider.of<ImageProviders>(context,listen: false).openBoxProvider();
    }
    else
    {
      print("zaten açık");
    }
    super.initState();
  }

  @override
  void dispose()
  {
    closeBox();
    super.dispose();
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

  _appbar()
  {
    final prov = Provider.of<ImageProviders>(context,listen: false);

    return AppBar
    (
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80.h,
      title: const TitleText(text: "Favorites"),
      actions:
      [
        IconButton(onPressed:()
        {
          if(Hive.isBoxOpen("favs"))
          {
            prov.clearBoxprovider();
          }
          else
          {
            _snack("Try Again!");
            prov.openBoxProvider();
          }
        },
        icon: Icon(Icons.clear,color: Colors.grey.shade800))
      ],
    );
  }

  _favList()
  {
    final prov = Provider.of<ImageProviders>(context);
    final orientation = MediaQuery.of(context).orientation;

    if(Hive.isBoxOpen("favs"))
    {
      return prov.favList.isNotEmpty ?
      GridView.builder
      (
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 150.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
        (
          childAspectRatio: 2/3,
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: prov.favList.length,
        itemBuilder: (context, i)
        {
          return Stack
          (
            children:
            [
              GestureDetector
              (
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
                DetailedImagePage
                (
                  gelenImageInfo: null,
                  hiveFavImage: prov.favList[i].favImage,
                  hiveOriginalImage: prov.favList[i].favImageOriginal,
                  hiveInfo: prov.favList[i].favInfo,
                  hivePhotoID: prov.favList[i].favID,
                  hivePhotographer: prov.favList[i].favName,
                ))),
                child: Container
                (
                  decoration: BoxDecoration
                  (
                    borderRadius:BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(prov.favList[i].favImage),fit: BoxFit.cover)
                  )
                ),
              ),
              Align
              (
                alignment: Alignment.topRight,
                child: IconButton(onPressed: ()
                {
                  if(Hive.isBoxOpen("favs"))
                  {
                    prov.favList[i].delete();
                    prov.setBox();
                  }
                  else
                  {
                    _snack("Try Again!");
                    Provider.of<ImageProviders>(context,listen: false).openBoxProvider();
                  }
                },
                icon: const Icon(Icons.favorite,color: Colors.red)),
              ),
            ]
          );
        }
      )
      : infoTxt("Box is empty!",24);
    }
    else
    {
      return loadingIndicator();
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: _appbar(),
      body: _favList(),
    );
  }
}