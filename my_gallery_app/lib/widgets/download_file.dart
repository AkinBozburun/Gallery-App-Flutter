import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future openFile({required String url}) async
{
  final name = url.split("/").last; //url adlı linkten, son slash'den sonraki kısmı alacak.
  final file = await downloadFile(url, name);
  if(file == null) return;

  OpenFile.open(file.path);
}

Future<File?> downloadFile(String url, String name) async
{
  final appStorage = await getExternalStorageDirectory();
  final file = File("${appStorage?.path}/$name");

  try
  {
    final response = await Dio().get(url,
      options: Options
      (
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0,
      )
    );

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  }
  catch(e)
  {
    print("hatalı");
    return null;
  }
}