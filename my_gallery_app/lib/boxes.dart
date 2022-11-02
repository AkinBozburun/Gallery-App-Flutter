import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_gallery_app/model/fav_model.dart';

class Boxes
{
  static Box<Favs> getFavs() => Hive.box<Favs>("favs");
}