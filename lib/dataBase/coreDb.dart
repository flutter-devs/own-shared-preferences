import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class CoreDb {
  //Creating singleton of CoreDb
  CoreDb._();
  static CoreDb _obj;
  static instance() {
    if (_obj == null) _obj = CoreDb._();
    return _obj;
  }

//getting appliction directory : this directory will remain until you clear your app data
// clearing cache wont help.

  Future<String> get _localPath async {
    final directory =
        await getApplicationDocumentsDirectory(); //from package :path_provider
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File(
        '$path/preference.json'); //returning file using the obtained path from path provider
  }

  void writeData(Map data) async {
    File file = await _localFile;
    Map<String, dynamic> tempMap; //temporaray map to store data

    if (await file.exists()) {
      tempMap = json.decode(
          file.readAsStringSync()); //storing all data in file in tempMap
      tempMap.addAll(data); //adding data to tempMap
      file.writeAsStringSync(json.encode(
          tempMap)); //writing the updated data to the same file without appending
    } else {
      file.writeAsStringSync(
          json.encode(data)); //if file dosent exist write it as it is
    }
  }

  Future<Map> getData({String key}) async {
    File tempFile = await _localFile; //obtaining the file
    if (await tempFile.exists()) {
      return json.decode(tempFile.readAsStringSync()); //returning Map as data
    } else
      return null;
  }

  Future deleteData(
      String dataToDelete, Function onDelte, Function ifNotExist) async {
    File tempFile = await _localFile;
    if (!tempFile.existsSync()) {
      ifNotExist();
    } else {
      Map data = json.decode(tempFile.readAsStringSync());
      var result = data.remove(dataToDelete);
      if (result == null) {
        ifNotExist();
      } else {
        tempFile.writeAsStringSync(json.encode(data));
        onDelte();
      }
    }
  }
}
