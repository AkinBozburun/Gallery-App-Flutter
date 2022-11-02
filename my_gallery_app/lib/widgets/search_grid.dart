import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_gallery_app/pages/detailed_image_page.dart';
import 'package:my_gallery_app/providers.dart';
import 'package:my_gallery_app/widgets/texts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchGrid extends StatelessWidget
{
  const SearchGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;
    final prov = Provider.of<ImageProviders>(context);

    return prov.resultTotal == 0 ? infoTxt("Photos not found!",22) : prov.searchImagesList.isEmpty ?
    infoTxt("Your search will list here!",22) : SingleChildScrollView
    (
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          SizedBox(height: 20.h),
          Padding
          (
            padding: const EdgeInsets.only(left:10),
            child: ResultText(resultCount: prov.resultTotal, searchTxt: prov.searchResultTxt!)
          ),
          SizedBox(height: 20.h),
          StaggeredGridView.countBuilder
          (
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 20.h,left: 5,right: 5),
            itemCount: prov.searchImagesList.length,
            crossAxisCount: orientation == Orientation.landscape? 6 : 3,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            staggeredTileBuilder:(i)=> i % 7 == 0 ?
            const StaggeredTile.count(2, 2) : const StaggeredTile.count(1, 1),
            itemBuilder:(_,i) => GestureDetector
            (
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
              DetailedImagePage
              (
                gelenImageInfo: prov.searchImagesList[i],
                hiveFavImage: null,
                hiveOriginalImage: null,
                hiveInfo: null,
                hivePhotoID: null,
                hivePhotographer: null,
              ))),
              child: ClipRRect
              (
                borderRadius: BorderRadius.circular(5),
                child: i % 7 == 0 ?
                Image.network(prov.searchImagesList[i]["src"]["large"],fit: BoxFit.cover) :
                Image.network(prov.searchImagesList[i]["src"]["medium"],fit: BoxFit.cover)
              ),
            ),
          ),
          Center
          (
            child: Padding
            (
              padding: EdgeInsets.only(bottom: 150.h),
              child: Column
              (
                children:
                [
                  infoTxt("Showing ${prov.searchImagesList.length} of ${prov.resultTotal} photos", 20),
                  ((){
                    if(prov.searchImagesList.length == prov.resultTotal)
                    {
                      return Container();
                    }
                    else
                    {
                      return ElevatedButton
                      (
                        onPressed: ()=> prov.searchImage(prov.searchResultTxt?? ""),
                        style: ElevatedButton.styleFrom
                        (
                          backgroundColor: const Color(0xFF1B5E20),
                          elevation: 5,
                        ),
                        child: const Text("More Photos"),
                      );
                    }
                  }()),
                ],
              )
            )
          )
        ],
      ),
    );
  }
}