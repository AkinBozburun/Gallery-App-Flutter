import 'package:hive/hive.dart';

part 'fav_model.g.dart';

@HiveType(typeId: 0)
class Favs extends HiveObject
{
  @HiveField(0)
  late int favID;

  @HiveField(1)
  late String favName;

  @HiveField(2)
  late String favInfo;

  @HiveField(3)
  late String favImage;

  @HiveField(4)
  late String favImageOriginal;
}