import 'package:flutter/material.dart';
import 'package:my_gallery_app/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget
{
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
{
  final cntrllr = TextEditingController();

  _backIcon()
  {
    final orientation = MediaQuery.of(context).orientation;
    final provider = Provider.of<ImageProviders>(context);

    if(provider.pageIndex == 1)
    {
      return IconButton(onPressed: ()
      {
        provider.categorieView();
      },
      icon: Icon(Icons.chevron_left, color: Colors.grey.shade600, size: orientation == Orientation.landscape? 25.sp : 40.sp));
    }
  }

  _clearBttn()
  {
    final provider = Provider.of<ImageProviders>(context);

    if(cntrllr.text != "")
    {
      return IconButton(onPressed: ()
      {
        provider.clearSearchList();
        cntrllr.clear();
      }, icon: Icon(Icons.clear,color: Colors.grey.shade600));
    }
    else
    {
      return null;
    }

  }

  _searchBar()
  {
    final orientation = MediaQuery.of(context).orientation;
    final prov = Provider.of<ImageProviders>(context);
    return SliverAppBar
    (
      floating: true,
      toolbarHeight: orientation == Orientation.landscape? 100.h : 60.h,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _backIcon(),
      title: Column
      (
        children:
        [
          Container
          (
            height: orientation == Orientation.landscape? 100.h: 50.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration
            (
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade400,
            ),
            child: TextField
            (
              onTap: () =>
              {
                if(cntrllr.text != "")
                {
                  prov.resultView(),
                }
              },
              onSubmitted: (_) {if(cntrllr.text != "")
              {
                prov.clearSearchList();
                prov.searchResultTxt = cntrllr.text;
                prov.searchImage(cntrllr.text);
                prov.resultsPageNo = 1;
                prov.resultView();
              }},
              controller: cntrllr,
              decoration: InputDecoration
              (
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search,size: 22),
                prefixIconColor: Colors.grey,
                suffixIcon: _clearBttn(),
                hintText: "Search",
                hintStyle: TextStyle(fontSize: orientation == Orientation.landscape? 13.sp: 24.sp,color: Colors.grey.shade700)
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    final prov = Provider.of<ImageProviders>(context);
    return Scaffold
    (
      body: NestedScrollView
      (
        floatHeaderSlivers: true,
        headerSliverBuilder:(context, innerBoxIsScrolled) =>[_searchBar()],
        body: prov.bodyMode[prov.pageIndex]
      )
    );
  }
}