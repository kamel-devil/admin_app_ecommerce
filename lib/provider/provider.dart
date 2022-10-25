import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/UserModel.dart';
import '../model/UserModel2.dart';
import '../model/UserModel3.dart';

class Funcprovider with ChangeNotifier {
  // List<Marker> mark = [];
  List loc = [];
  List cate = [];
  List passengers = [];
  List sub = [];
  List ownerData = [];
  List dropOwner = [];
  List dataCard = [];
  Map ownerEdit = {};
  Map userData = {};
  List<DropdownMenuItem<String>> owner = [];
  List servicesSh = [];
  List popshopsda = [];
  List dataRanking = [];

  Map shopda = {};
  Map infLogin = {};
  Map infShop = {};
  Map dataProfile = {};
  List sliderData = [];
  Map shop = {};
  double? lat;
  double? long;
  bool result = false;
  final RefreshController refreshController =
  RefreshController(initialRefresh: true);
  int currentPage = 1;

  // File? file;
  File? image;
  Map addressData = {};
  String address_en = '';
  String address_ar = '';
  final picker = ImagePicker();
  File? selectedFile;
  String? token;
  bool isLogin = false;
  String? subId;
  Locale lang = Locale('ar');

  Future getDatacate(String id) async {
    String url =
        'https://ibtikarsoft.net/finder/api/admin/shop_categories.php?lang=$lang&token=$token&cat=$id';
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        cate = data;
      }
    } else {
      print("Error");
    }
    // notifyListeners();
    return cate;
  }

  void change(double lat1, double long1) {
    lat = lat1;
    long = long1;
    notifyListeners();
  }

  void changeLogin(bool z) {
    isLogin = z;
    saveLogin(z);
  }

  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void askPermissionCamera() {
    requestPermission(Permission.camera).then(onStatusRequestedCamera);
  }

  void askPermissionStorage() {
    requestPermission(Permission.storage).then(onStatusRequested);
  }

  void askPermissionPhotos() {
    requestPermission(Permission.photos).then(onStatusRequested);
  }

  void onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.gallery);
    }
  }

  void onStatusRequestedCamera(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.camera);
    }
  }

  void getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      File? cropped = await ImageCropper.cropImage(
          sourcePath: image!.path,
          aspectRatio: const CropAspectRatio(ratioX: 1000, ratioY: 700),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          cropStyle: CropStyle.rectangle,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.original,
              toolbarColor: Colors.white,
              toolbarTitle: 'Edit Images',
              statusBarColor: Color(0xFF0181cc),
              activeControlsWidgetColor: Color(0xFF515151),
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              toolbarWidgetColor: Color(0xFF515151),
              backgroundColor: Colors.white,
              showCropGrid: false));
      if (cropped != null) {
        if (selectedFile != null && selectedFile!.existsSync()) {
          selectedFile!.deleteSync();
        }
        selectedFile = cropped;
      }

      // delete image camera
      if (source.toString() == 'ImageSource.camera' && image!.existsSync()) {
        image!.deleteSync();
      }

      image = null;
    }
    notifyListeners();
  }

  Future login(String email, password) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/login.php'),
        body: {"username": email, "password": password});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    token = infLogin['token'];
    print(token);

    return infLogin;
  }

  Future uploadShop(
    Map<String, String> data,
    File file,
  ) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/admin/shops_add.php?token=$token"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes(
        'image', File(file.path).readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);
    shop=json.decode(result);
    print(result);
    print('shop_id:'+shop['shop_id']);
    notifyListeners();
    // print(res.headers);
  }

  Future uploadOwner(
    Map<String, String> data,
    File file,
  ) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/admin/owners_add.php?token=$token"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes(
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

  Future updateOwner(
      {required Map<String, String> data,
      required String file,
      required String id}) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/admin/owners_edit.php?token=$token&owner=$id&action=update"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes('image', File(file).readAsBytesSync(),
        filename: file);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }

  datashop({required String id}) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/shop.php?token=$token&shop=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      shopda = x;
    }
    print(
        'https://ibtikarsoft.net/finder/api/admin/shop.php?token=$token&shop=$id');
    return shopda;
  }

  dataOwner() async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/owners.php?token=$token'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      ownerData = x;
      owner.clear();
      ownerData.forEach((element) {
        owner.add(DropdownMenuItem(
          value: element['id'],
          child: Text(element['f_name'] + element['l_name']),
        ));
      });
    }
    return owner;
  }

  Future<List<UserModel>> getData(filter) async {
    var response = await dio.Dio().get(
      "https://ibtikarsoft.net/finder/api/admin/owners.php?token=$token",
      queryParameters: {"filter": filter},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      dropOwner=data;
      print(data);
      if (data != null) {
        return UserModel.fromJsonList(data);
      }
      return [];
    }
    return [];
  }
  Future<List<UserModel2>> modules(filter) async {
    var response = await dio.Dio().get(
      "https://ibtikarsoft.net/finder/api/admin/modules.php?lang=$lang&token=$token",
      queryParameters: {"filter": filter},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      dropOwner=data;
      print(data);
      if (data != null) {
        return UserModel2.fromJsonList(data);
      }
      return [];
    }
    return [];
  }
  Future<List<UserModel3>> productCategories(filter,String id) async {
    var response = await dio.Dio().get(
      "https://ibtikarsoft.net/finder/api/admin/pcategories.php?lang=$lang&token=$token&module=$id",
      queryParameters: {"filter": filter},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      dropOwner=data;
      print(data);
      if (data != null) {
        return UserModel3.fromJsonList(data);
      }
      return [];
    }
    return [];
  }
  Future ranking(String time) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/ranking.php?lang=ar&token=aruv8kzsmyo7&type=$time'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      dataRanking = x;
    }
    print('https://ibtikarsoft.net/finder/api/admin/ranking.php?lang=ar&token=aruv8kzsmyo7&type=$time');
    print(dataRanking);
    return dataRanking;
  }

  editOwner({required String id}) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/owners_edit.php?token=$token&owner=$id&action=edit'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      ownerEdit = x;
      // if (x.isNotEmpty) {
      //   ownerEdit = x;
      //
      //   fName = x['f_name'];
      //   lName = x['l_name'];
      //   userName = x['username'];
      //   phone = x['phone'];
      //   image=x['image'];
      //   print(fName);
      // }
    }
    return ownerEdit;
  }

   void getAddressInfo(double latAddress, double longAddress,) async {
    String url =
        'https://ibtikarsoft.net/finder/api/admin/address_info.php?lat=$latAddress&long=$longAddress';
    print(url);
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      Map data = json.decode(res.body);
      print('++++++++++++++++++');
      print(data);
      if (data.isNotEmpty) {
        addressData = data;

        address_en = data['en'];
        address_ar = data['ar'];
        print('_____________________');
        print(address_en);
        print(address_ar);
      }
    } else {
      print("Error");
    }
   }

  Future<bool> getPassengerData(String search,String id,{bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      // if (currentPage >= totalPages) {
      //   refreshController.loadNoData();
      //   return false;
      // }
      if (passengers.isEmpty) {
        refreshController.loadNoData();
        return false;
      }
    }


    final Uri uri = Uri.parse(
        "https://ibtikarsoft.net/finder/api/admin/shops.php?token=$token&lang=$lang&lat=$lat&long=$long&cat=$id&page=$currentPage&search=$search");

    final response = await get(uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (isRefresh) {
        passengers = result;
      }else{
        passengers.addAll(result);
      }

      currentPage++;

      // totalPages = result[4];
      notifyListeners();
      print(response.body);
      print(Uri);
      return true;
    } else {
      return false;
    }
  }

  subscription() async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/subs.php?token=$token'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      sub = x;
    }
    return sub;
  }

  Future Servicessh(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/services.php?lang=$lang&shop=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      servicesSh = x;
    }
    return servicesSh;
  }

  datapopshops(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/shops.php?token=$token&lang=$lang&lat=$lat&long=$long&cat=$id&pop=1'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      popshopsda = x;
    }
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

  Future saveToken(String vall) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', vall);
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    notifyListeners();
    return prefs.getString('token');
  }

  Future saveLogin(bool vall) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', vall);
  }

  Future getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('login') ?? false;
    return prefs.getBool('login');
  }

  void setID(String id) {
    subId = id;
    notifyListeners();
  }

  saveUserData(String image, String token, String f_name, String l_name) async {
    var prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> dataUser = {
      "token": token,
      "f_name": f_name,
      "l_name": l_name,
      "image": image
    };
    String encodedMap = json.encode(dataUser);
    prefs.setString('userData', encodedMap);
  }

  Future getDataUser() async {
    var prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString('userData');
    userData = json.decode(encodedMap!);
    return userData;
  }

  Future<void> clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userData');
  }

  void changeLang(Locale locale) {
    lang = locale;
  }

  profile() async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/profile.php?lang=$lang&token=$token&action=show'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      dataProfile = x;
    }
    print(dataProfile);
    return dataProfile;
  }

  Future updateProfileWithImage(
  String file) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=update"));

    // request.fields.addAll(data!);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes('image', File(file).readAsBytesSync(),
        filename: file);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }
  Future updateProfileName(String fName, lName) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=update'),
        body: {"f_name": fName, "l_name": lName});
    Map x = json.decode(response.body);
    infLogin = x;

    return infLogin;
  }
  Future updateProfilePhone(String phone) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=update'),
        body: {"phone": phone});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }
  Future updateProfileEmail(String email) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=update'),
        body: {"email": email});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }
  Future updateProfileAddress(String address) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=update'),
        body: {"address": address});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }
  Future updateProfileUsername(String username) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=update'),
        body: {"username": username});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }
  Future updateProfileBirth(String dob) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=update'),
        body: {"dob": dob});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }
  Future updateProfilePassword(String old_pass,String new_pass) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/admin/profile.php?lang=ar&token=$token&action=password'),
        body: {"old_pass": old_pass,'new_pass':new_pass});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }

   card() async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/home_cards.php?lang=$lang&token=$token'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      dataCard = x;
    }
    print('-------------------');
    print(dataCard);
    return dataCard;
  }

}
