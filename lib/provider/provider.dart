import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:universal_io/io.dart' as IO;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Funcprovider with ChangeNotifier {
  // List<Marker> mark = [];
  List loc = [];
  List cate = [];
  List shopsda = [];
  List ownerData = [];
  List servicesSh = [];
  List popshopsda = [];
  Map shopda = {};
  List sliderData = [];
  double? lat;
  double? long;
  bool result = false;
  File? file;
  Map addressData = {};
  String address = '';

  datacate(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/categories.php?lang=ar&cat=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      cate = x;
      cate.forEach((element) {});
    }
    notifyListeners();
    return cate;
  }

  void change(double lat1, double long1) {
    lat = lat1;
    long = long1;
    notifyListeners();
  }

  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    notifyListeners();

    return result;
  }

  void askPermissionCamera() {
    requestPermission(Permission.camera).then(_onStatusRequestedCamera);
    notifyListeners();
  }

  void askPermissionStorage() {
    requestPermission(Permission.storage).then(_onStatusRequested);
    notifyListeners();
  }

  void askPermissionPhotos() {
    requestPermission(Permission.photos).then(_onStatusRequested);
    notifyListeners();
  }

  void _onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (IO.Platform.isAndroid) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.gallery);
    }
    notifyListeners();
  }

  void _onStatusRequestedCamera(status) {
    if (status != PermissionStatus.granted) {
      if (IO.Platform.isAndroid) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.camera);
    }
    notifyListeners();
  }

  Future getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: source);
//TO convert Xfile into file
    file = File(image!.path);
    notifyListeners();

//print(‘Image picked’);
    return file;
  }

  login(String email, password) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/mapapi/admin_login.php'),
        body: {"username": email, "password": password});
    print('--------------------');
    print(response.body);
    notifyListeners();
  }

  uploadShop(
    Map<String, String> data,
    File file,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://ibtikarsoft.net/mapapi/shop_add.php"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = http.MultipartFile.fromBytes(
        'image', File(file.path).readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }

  uploadOwner(
    Map<String, String> data,
    File file,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://ibtikarsoft.net/mapapi/owners_add.php"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = http.MultipartFile.fromBytes(
        'image', File(file.path).readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }

  datashop(String id) async {
    var D = await get(
        Uri.parse('https://ibtikarsoft.net/mapapi/shop.php?lang=ar&shop=18'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      shopda = x;
    }
    notifyListeners();
    return shopda;
  }

  dataOwner() async {
    var D = await get(Uri.parse('https://ibtikarsoft.net/mapapi/owners.php'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      ownerData = x;
      ownerData.forEach((element) {});
    }
    notifyListeners();
    return ownerData;
  }

  datashops(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/shops.php?lang=ar&lat=30.0374562&long=31.2095052&cat=0'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      shopsda = x;
    }
    notifyListeners();
    return shopsda;
  }

  Future Servicessh(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/services.php?lang=ar&shop=8'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      servicesSh = x;
    }
    return servicesSh;
  }

  datapopshops(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/shops.php?lang=ar&lat=30.0374562&long=31.2095052&cat=0&pop=1'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      popshopsda = x;
    }
    notifyListeners();
    return popshopsda;
  }

  Future<Position?> getCheckLocation() async {
    Geolocator.checkPermission().then((value) {
      print(value);
      if (value == LocationPermission.denied) {
        Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied) {
            print("denied");
          } else if (value == LocationPermission.whileInUse) {
            print('go ');
            getCurrentLocation();
            notifyListeners();
          } else {}
        });
      } else {
        getCurrentLocation();
      }
    });
    notifyListeners();
    return null;
  }

  Future<Position?> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position? lastPsition = await Geolocator.getLastKnownPosition();
    print('------------------------**-----------**--------');
    print(lastPsition?.latitude);
    print(lastPsition?.longitude);
    lat = lastPsition!.latitude;
    long = lastPsition.longitude;
    datacate('0');
    notifyListeners();
    return lastPsition;
    // locationMessage="$position.latitude ,$position.longitude";
  }

  checkEnternet() async {
    bool result1 = await InternetConnectionChecker().hasConnection;
    if (result1 == true) {
      print('Connection Done');
    } else {
      print('Connection failed');
    }

    result = result1;
    notifyListeners();
  }

  void getAddressInfo(double latAddress, double longAddress) async {
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latAddress&lon=$longAddress&accept-language=eg-Arab';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      Map data = json.decode(res.body);
      if (data.isNotEmpty) {
        addressData = data;

        address = data['display_name'];
        print(address);
        notifyListeners();

      }
    } else {
      print("Error");
    }
  }
}
