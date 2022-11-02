import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_gallery_app/pages/detailed_image_page.dart';
import 'package:my_gallery_app/providers.dart';
import 'package:my_gallery_app/widgets/_widgets.dart';
import 'package:my_gallery_app/widgets/texts.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget
{
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
{
  final controller = ScrollController();

  _cacheControl()
  {
    final prov = Provider.of<ImageProviders>(context,listen: false);
    if(prov.exploreImagesList.isEmpty)
    {
      prov.exploreImages();
    }
    FlutterNativeSplash.remove();
  }

  _scrollControl()
  {
    controller.addListener(()
    {
      if(controller.position.maxScrollExtent == controller.offset)
      {
        Provider.of<ImageProviders>(context,listen: false).exploreImages();
      }
    });
  }

  @override
  void initState()
  {
    _cacheControl();
    _scrollControl();
    super.initState();
  }

  _exploreGrid()
  {
    final exploreList = Provider.of<ImageProviders>(context).exploreImagesList;
    final orientation = MediaQuery.of(context).orientation;

    return exploreList.isEmpty ? GridView.builder
    (
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
      (
        crossAxisCount: 2,
        childAspectRatio: 2/3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(15),
      itemCount: 5,
      itemBuilder: (context, index) => shimmerEffect(1, 1),
    ) :
    StaggeredGridView.countBuilder
    (
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      itemCount: exploreList.length+6,
      crossAxisCount: orientation == Orientation.landscape? 6:3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      staggeredTileBuilder:(i)=> i % 6 == 0 ?
      const StaggeredTile.count(2, 2) : const StaggeredTile.count(1, 1),
      itemBuilder:(_,i)
      {
        if(i < exploreList.length)
        {
          return GestureDetector
          (
            onTap:()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              DetailedImagePage
              (
                gelenImageInfo: exploreList[i],
                hiveFavImage: null,
                hiveOriginalImage: null,
                hiveInfo: null,
                hivePhotoID: null,
                hivePhotographer: null,
              )));
            },
            child: ClipRRect
            (
              borderRadius: BorderRadius.circular(5),
              child: i % 6 == 0 ? Image.network(exploreList[i]["src"]["large"],fit: BoxFit.cover) :
              Image.network(exploreList[i]["src"]["medium"],fit: BoxFit.cover)
            ),
          );
        }
        else
        {
          return shimmerEffect(1,1);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView
    (
      controller: controller,
      child: Column
      (
        children:
        [
          AppBar
          (
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const TitleText(text: "Explore Photos"),
          ),
          _exploreGrid(),
        ],
      ),

    );
  }
}