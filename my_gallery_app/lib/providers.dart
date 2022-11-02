import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_gallery_app/boxes.dart';
import 'package:my_gallery_app/model/fav_model.dart';
import 'package:my_gallery_app/widgets/categories_body.dart';
import 'package:my_gallery_app/widgets/search_grid.dart';

class ImageProviders extends ChangeNotifier
{
  pageChange(i,pageNo)
  {
    pageNo = i;
    notifyListeners();
  }

  List exploreImagesList = [];
  List searchImagesList = [];

  int resultTotal = 0;

  String authKey = "563492ad6f91700001000001cb29840f540c4a599c2c090b74093d40";

  int pageNo = 1;

  exploreImages() async
  {
    await http.get
    (
      Uri.parse("https://api.pexels.com/v1/curated?per_page=30&page=$pageNo"),
      headers: {'Authorization': authKey}
    ).then((value)
    {
      Map result = jsonDecode(value.body);
      _listImages(result["photos"]);
    });
  }
  _listImages(result)
  {
    exploreImagesList.addAll(result);
    pageNo++;
    notifyListeners();
    print("fetched");
  }
  clearSearchList()
  {
    searchImagesList = [];
    notifyListeners();
  }
  int resultsPageNo = 1;

  searchImage(String gelenArama) async
  {
    await http.get
    (
      Uri.parse("https://api.pexels.com/v1/search?query=$gelenArama&per_page=48&page=$resultsPageNo"),
      headers: {'Authorization': authKey}
    ).then((value)
    {
      Map result = jsonDecode(value.body);
      print(resultsPageNo);
      resultsPageNo++;
      _listSearch(result);
    });
  }
  _listSearch(result)
  {
    resultTotal = result["total_results"];
    searchImagesList.addAll(result["photos"]);
    notifyListeners();
  }

  String? searchResultTxt;

  List bodyMode = [const CategoriesBody(), const SearchGrid()];
  int pageIndex = 0;

  categorieView()
  {
    pageIndex = 0;
    notifyListeners();
  }
  resultView()
  {
    pageIndex = 1;
    notifyListeners();
  }

  openBoxProvider() async
  {
    await Hive.openBox<Favs>("favs");
    notifyListeners();
    print("box açıldı");
    setBox();
  }
  setBox()
  {
    if(Hive.isBoxOpen("favs"))
    {
      favList = Boxes.getFavs().values.toList().cast<Favs>();
    }
    notifyListeners();
  }

  List favList = [];

  clearBoxprovider()
  {
    Hive.box<Favs>("favs").clear();
    favList = [];
    notifyListeners();
  }
}