import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_gallery_app/model/fav_model.dart';
import 'package:my_gallery_app/providers.dart';
import 'package:my_gallery_app/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

void main() async
{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle
  (
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  WidgetsBinding wb = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: wb);

  await Hive.initFlutter();
  Hive.registerAdapter(FavsAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider
  (
    providers:
    [
      ChangeNotifierProvider(create: (context) => ImageProviders()),
    ],
    child: ScreenUtilInit
    (
      designSize: const Size(540, 912),
      builder: (context, _) => MaterialApp
      (
        debugShowCheckedModeBanner: false,
        theme: ThemeData
        (
          scaffoldBackgroundColor: Colors.grey.shade200,
          appBarTheme: const AppBarTheme
          (
            systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness:Brightness.dark),
          ),
        ),
        title: "MyGallery",
        home: const BottomNavBar(),
      ),
    ),
  );
}