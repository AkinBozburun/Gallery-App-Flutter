import 'package:flutter/material.dart';
import 'package:my_gallery_app/providers.dart';
import 'package:provider/provider.dart';

class ColorsList extends StatelessWidget
{
  ColorsList({Key? key}) : super(key: key);

  List colors =
  [
    {
      "name" : "Red",
      "color" : Colors.red,
    },
    {
      "name" : "Orange",
      "color" : Colors.orange,
    },
    {
      "name" : "Yellow",
      "color" : Colors.yellow,
    },
    {
      "name" : "Green",
      "color" : Colors.green,
    },
    {
      "name" : "Blue",
      "color" : Colors.blue,
    },
    {
      "name" : "Khaki",
      "color" : Colors.lime.shade800,
    },
    {
      "name" : "Purple",
      "color" : Colors.purple,
    },
    {
      "name" : "Black",
      "color" : Colors.black,
    },
    {
      "name" : "White",
      "color" : Colors.white,
    },
    {
      "name" : "Grey",
      "color" : Colors.grey,
    },
    {
      "name" : "beige",
      "color" : const Color(0xfffaf0e6),
    },
  ];

  @override
  Widget build(BuildContext context)
  {
    final orientation = MediaQuery.of(context).orientation;
    final prov = Provider.of<ImageProviders>(context);
    return GridView.builder
    (
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
      (
        crossAxisCount: orientation == Orientation.landscape? 15 : 8,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: colors.length,
      itemBuilder:(_,i)=> GestureDetector
      (
        onTap: () async
        {
          prov.searchImagesList = [];
          prov.searchResultTxt = colors[i]["name"];
          await prov.searchImage(colors[i]["name"]);
          prov.resultView();
        },
        child: Container
        (
          decoration: BoxDecoration
          (
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade400),
            color: colors[i]["color"],
          ),
        ),
      ),
    );
  }
}