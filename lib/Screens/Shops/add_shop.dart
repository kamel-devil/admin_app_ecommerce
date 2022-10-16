//Location
//lang

import 'package:dropdown_search/dropdown_search.dart';
import 'package:e_commerce/Screens/Shops/shops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart' as IO;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../presentation/constant.dart';
import '../../provider/provider.dart';
import '../../res/color_data.dart';
import '../../sub/categoryItem.dart';
import '../../sub/meals_list_data.dart';
import '../UserModel.dart';
import '../home_admin.dart';
import '../../map/tools/map.dart';

class AddShop extends StatefulWidget {
  const AddShop({Key? key, this.animationController}) : super(key: key);
  final AnimationController? animationController;

  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> with TickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _usernamear = '';
  String _email = '';
  String address = '';

  String addressAr = '';
  String description = '';
  int selectedCategoryIndex = 0;
  String descriptionar = '';
  String? _selectedGender ;
  int _phone = 011111111111;
  int _phone2 = 011111111111;
  bool _termsChecked = true;
  dynamic _selectedFile;
  bool showPh = false;
  DateTime _dateTime = DateTime.now();
  List<DropdownMenuItem<int>> genderList = [];
  String? idCate;
  String? idOwner;
  int count = 9;
  String sub_Id='';
  int? chang;

  AnimationController? animationController;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      value: 0,
      child: Text('FREE'),
    ));
    genderList.add(const DropdownMenuItem(
      value: 1,
      child: Text('PAY'),
    ));
    genderList.add(const DropdownMenuItem(
      value: 2,
      child: Text('Others'),
    ));
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      if (_selectedFile != null && _selectedFile!.existsSync()) {
        _selectedFile!.deleteSync();
      }
    }
    _selectedFile = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);
    p.getAddressInfo(p.lat!,p.long!,lang1: Locale('en') ).then((value) {
      print(value);
    });
    print('--------aaaa-------------');

    TextEditingController controller = TextEditingController(text: p.address);
    TextEditingController controller1 = TextEditingController(text: p.address);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,

          title: const Text(
            'Statistics',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),

          // leading:
          //
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.arrow_back_ios_new_outlined),color: Colors.black,),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => homeAdmin()));
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
          ],
        ),
        // drawer: Drawer(
        //     // backgroundColor: Colors.black,
        //     child: ListView(
        //   padding: EdgeInsets.zero,
        //   children: <Widget>[
        //     const UserAccountsDrawerHeader(
        //       accountName: Text("Ashish Rawat"),
        //       accountEmail: Text("ashishrawat2911@gmail.com"),
        //       currentAccountPicture: CircleAvatar(
        //         backgroundColor: Colors.white,
        //         child: Text("A", style: TextStyle(fontSize: 40.0)),
        //       ),
        //     ),
        //     ListTile(
        //       title: const Text('Shops'),
        //       trailing: const Icon(Icons.arrow_forward),
        //       onTap: () {
        //         Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context) => const Shops()));
        //       },
        //     ),
        //     ListTile(
        //       title: const Text('Add new shop'),
        //       onTap: () {
        //         Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context) => const AddShop()));
        //       },
        //     ),
        //     ListTile(
        //       title: const Text('Owners'),
        //       onTap: () {
        //         Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context) => const Owners()));
        //       },
        //     ),
        //     ListTile(
        //       title: const Text('Add new owner'),
        //       onTap: () {
        //         Navigator.of(context)
        //             .push(MaterialPageRoute(builder: (context) => AddOwner()));
        //       },
        //     ),
        //   ],
        // )),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _getImageWidget(),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (!kIsWeb)
                          ? GestureDetector(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Icon(
                                    Icons.camera_alt,
                                    color: BLACK77,
                                    size: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Camera'),
                                ],
                              ),
                              onTap: () {
                                p.askPermissionCamera();
                              },
                            )
                          : const SizedBox.shrink(),
                      Container(
                        width: (!kIsWeb) ? 20 : 0,
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.photo,
                              color: BLACK77,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Text('Gallery'),
                          ],
                        ),
                        onTap: () {
                          if (kIsWeb) {
                            p.getImage(ImageSource.gallery);
                          } else {
                            if (IO.Platform.isAndroid) {
                              p.askPermissionPhotos();
                            } else {
                              p.askPermissionStorage();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  // FutureBuilder(
                  //   future: p.dataOwner(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return DropdownButton(
                  //         hint: const Text('Select '),
                  //         items: p.owner,
                  //         value: _selectedGender,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             _selectedGender =value.toString() ;
                  //           });
                  //         },
                  //         isExpanded: true,
                  //       );
                  //     } else {
                  //       return const CircularProgressIndicator();
                  //     }
                  //   },
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownSearch<UserModel>(
                          onChanged: (value){
                            print(value!.id);
                            setState(() {
                              _selectedGender=value.id;
                            });
                            print(_selectedGender);
                          },
                          asyncItems: (filter) {
                            print('------------------------');
                            print(filter);

                            return
                             p.getData(filter);
                          } ,                          compareFn: (i, s) => i.isEqual(s),
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            isFilterOnline: true,
                            showSelectedItems: true,
                            showSearchBox: true,
                            itemBuilder: _customPopupItemBuilderExample2,
                            favoriteItemProps: FavoriteItemProps(
                              showFavoriteItems: true,
                              favoriteItems: (us) {
                                return us
                                    .where((e) => e.name.contains("Mrs"))
                                    .toList();
                              },
                            ),
                          ),

                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                actions: [
                                  SizedBox(
                                    height: 180,
                                    child: CupertinoDatePicker(
                                      initialDateTime: _dateTime,
                                      minimumYear: 2018,
                                      maximumYear: DateTime.now().year + 6,
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (dateTime) {
                                        setState(() {
                                          _dateTime = dateTime;
                                        });
                                      },
                                    ),
                                  )
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    final value = DateFormat('MMMM dd, yyyy')
                                        .format(_dateTime);
                                    Fluttertoast.showToast(
                                        msg: value,
                                        toastLength: Toast.LENGTH_SHORT);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.calendar_today_rounded),
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                label: Text(DateFormat('MMMM dd, yyyy')
                                    .format(_dateTime))),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Enter Email', hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (x) {
                      validateEmail(x);
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _email = value.toString();
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Phone', labelText: 'Enter Phone'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Phone';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _phone = int.parse(value.toString());
                      });
                    },
                  ),
                  showPh
                      ? TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Phone', labelText: 'Enter Phone'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Phone';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              _phone2 = int.parse(value.toString());
                            });
                          },
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            showPh = !showPh;
                          });
                        },
                        child: const Text("add anthor phone"),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blue,
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        children: [
                          const Text('English'),
                          const Icon(Icons.language),
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'Adminshop',
                                      labelText: 'User shop'),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter user shop';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _username = value.toString();
                                    });
                                  },
                                ),
                                TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'Description',
                                        labelText: 'Description'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Description';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        description = value.toString();
                                      });
                                    }),
                                TextFormField(
                                    controller: controller,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      hintText: p.address,
                                      labelText: 'Address',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          p
                                              .getCurrentLocation()
                                              .whenComplete(() {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Map1()));
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.edit_location_sharp),
                                      ),
                                    ),
                                    validator: (address) {
                                      if (address != null && address.isEmpty) {
                                        return 'Enter Address';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        address = value.toString();
                                      });
                                    }),
                              ],
                            ),
                          ),
                          const Text('Arabic'),
                          const Icon(Icons.language),
                          Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'اسم المحل',
                                        labelText: 'اسم المحل'),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ادخل اسم المحل';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _usernamear = value.toString();
                                      });
                                    },
                                  ),
                                  TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'الوصف',
                                          labelText: 'الوصف'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'ادخل الوصف';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          descriptionar = value.toString();
                                        });
                                      }),
                                  TextFormField(
                                      controller: controller1,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        hintText: 'العنوان',
                                        labelText: 'ادخل العنوان',
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            p
                                                .getCurrentLocation()
                                                .whenComplete(() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Map1()));
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.edit_location_sharp),
                                        ),
                                      ),
                                      validator: (addressAr) {
                                        if (addressAr != null &&
                                            addressAr.isEmpty) {
                                          return 'ادخل العنوان';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          addressAr = value.toString();
                                        });
                                      }),
                                ],
                              )),
                        ],
                      ),
                      // child: ContainedTabBarView(
                      //
                      //   tabs:  const [
                      //     Tab(
                      //       text: 'English',
                      //       icon: Icon(Icons.language),
                      //     ),
                      //     Tab(text: 'Arabic', icon: Icon(Icons.language)),
                      //   ],
                      //   views: [
                      //     Container(
                      //       color: Colors.white,
                      //       child: Column(
                      //         children: [
                      //           TextFormField(
                      //             decoration: const InputDecoration(
                      //                 hintText: 'Adminshop', labelText: 'User shop'),
                      //             keyboardType: TextInputType.text,
                      //             validator: (value) {
                      //               if (value!.isEmpty) {
                      //                 return 'Enter user shop';
                      //               } else {
                      //                 return null;
                      //               }
                      //             },
                      //             onSaved: (value) {
                      //               setState(() {
                      //                 _username = value.toString();
                      //               });
                      //             },
                      //           ),
                      //           TextFormField(
                      //               decoration: const InputDecoration(
                      //                   hintText: 'Description', labelText: 'Description'),
                      //               validator: (value) {
                      //                 if (value!.isEmpty) {
                      //                   return 'Please Enter Description';
                      //                 } else {
                      //                   return null;
                      //                 }
                      //               },
                      //               onSaved: (value) {
                      //                 setState(() {
                      //                   description = value.toString();
                      //                 });
                      //               }),
                      //           TextFormField(
                      //             controller: controller,
                      //             maxLines: 2,
                      //               decoration:  InputDecoration(
                      //                   hintText: p.address, labelText:'Address',
                      //
                      //               ),
                      //               validator: (address) {
                      //                 if (address != null && address.isEmpty) {
                      //                   return 'Enter Address';
                      //                 } else {
                      //                   return null;
                      //                 }
                      //               },
                      //               onSaved: (value) {
                      //                 setState(() {
                      //                   address = value.toString();
                      //                 });
                      //               }
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       color: Colors.white,
                      //       child: Column(
                      //         children: [
                      //           TextFormField(
                      //             decoration: const InputDecoration(
                      //                 hintText: 'اسم المحل', labelText: 'اسم المحل'),
                      //             keyboardType: TextInputType.text,
                      //             validator: (value) {
                      //               if (value!.isEmpty) {
                      //                 return 'ادخل اسم المحل';
                      //               } else {
                      //                 return null;
                      //               }
                      //             },
                      //             onSaved: (value) {
                      //               setState(() {
                      //                 _usernamear = value.toString();
                      //               });
                      //             },
                      //           ),
                      //           TextFormField(
                      //               decoration: const InputDecoration(
                      //                   hintText: 'الوصف', labelText: 'الوصف'),
                      //               validator: (value) {
                      //                 if (value!.isEmpty) {
                      //                   return 'ادخل الوصف';
                      //                 } else {
                      //                   return null;
                      //                 }
                      //               },
                      //               onSaved: (value) {
                      //                 setState(() {
                      //                   descriptionar = value.toString();
                      //                 });
                      //               }),
                      //           TextFormField(
                      //
                      //               decoration: const InputDecoration(
                      //                   hintText: 'العنوان', labelText: 'ادخل العنوان'),
                      //               validator: (addressAr) {
                      //                 if (addressAr != null && addressAr.isEmpty) {
                      //                   return 'ادخل العنوان';
                      //                 } else {
                      //                   return null;
                      //                 }
                      //               },
                      //               onSaved: (value) {
                      //                 setState(() {
                      //                   addressAr = value.toString();
                      //                 });
                      //               }),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ),
                  ),
                  // FutureBuilder(
                  //   future: p.datacate('0'),
                  //   builder: (context, snapshot) {
                  //
                  //   if(snapshot.hasData && p.cate.isNotEmpty){
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: SizedBox(
                  //         height: 50,
                  //         child: ListView.separated(
                  //           shrinkWrap: true,
                  //           separatorBuilder: (context, index) => const SizedBox(
                  //             width: 15,
                  //           ),
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: p.cate.length,
                  //           itemBuilder: (context, index) => ElevatedButton.icon(
                  //             style: ButtonStyle(
                  //               backgroundColor:
                  //               MaterialStateProperty.all<Color>(Colors.blue),
                  //               shape: MaterialStateProperty.all<
                  //                   RoundedRectangleBorder>(
                  //                 RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(22.0),
                  //                 ),
                  //               ),
                  //             ),
                  //             onPressed: () async {
                  //               p.datacate(p.cate[index]['id']) ;
                  //               setState(() {
                  //                 idCate = p.cate[index]['id'];
                  //               });
                  //             },
                  //             icon: Icon(
                  //               IconDataSolid(
                  //                   int.parse(p.cate[index]['icon_name'])),
                  //               color: HexColor.fromHex(p.cate[index]['color']),
                  //             ),
                  //             label: Text(
                  //               p.cate[index]['name'],
                  //               style: const TextStyle(
                  //                   fontSize: 20, fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }else{
                  //     return CircularProgressIndicator();
                  //   }
                  //
                  //   }
                  // ),
                  Consumer<Funcprovider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return FutureBuilder(
                          future: value.getDatacate('$idCate'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                value.cate.isNotEmpty) {
                              final list = snapshot.data as List;
                              return SingleChildScrollView(
                                padding:
                                const EdgeInsets.fromLTRB(15, 5, 7, 10),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    list.length,
                                        (index) => Padding(
                                      padding:
                                      const EdgeInsets.only(right: 8),
                                      child: CategoryItem(
                                        data: list[index],
                                        isSelected:
                                        index == selectedCategoryIndex,
                                        onTap: () {
                                          // value.getData(list[index]['id']);
                                          setState(() {
                                            selectedCategoryIndex = index;
                                            idCate = list[index]['id'];
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          });
                    },
                  ),
                   SizedBox(
                    height: 240,
                    child: FutureBuilder(
                        future: p.subscription(),
                        builder: (context, snapshot) {
                          if(p.sub.isNotEmpty){
                            final list=snapshot.data as List;
                            return SizedBox(
                              height: 216,
                              width: double.infinity,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 0, right: 16, left: 16),
                                itemCount: list.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  final int count =
                                  list.length > 10 ? 10 : list.length;
                                  final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval((1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                                  animationController?.forward();

                                  return AnimatedBuilder(
                                    animation: animationController!,
                                    builder: (BuildContext context, Widget? child) {
                                      return FadeTransition(
                                        opacity:animation,
                                        child: Transform(
                                          transform: Matrix4.translationValues(
                                              100 * (1.0 - animation.value), 0.0, 0.0),
                                          child: SizedBox(
                                            width: 170,
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 32, left: 8, right: 8, bottom: 16),
                                                  child: InkWell(
                                                    onTap: (){
                                                      list[index]['id'];
                                                      setState(() {
                                                        sub_Id =   list[index]['id'];
                                                        chang=index;
                                                      });
                                                      print(sub_Id);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                              color: Colors.blueGrey
                                                                  .withOpacity(0.6),
                                                              offset: const Offset(1.1, 4.0),
                                                              blurRadius: 8.0),
                                                        ],
                                                        gradient:  chang==index
                                                        ?const LinearGradient(
                                                          colors: [
                                                            Colors.pinkAccent,
                                                            Colors.pinkAccent
                                                          ],
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                        ):const LinearGradient(
                                                          colors: [
                                                            Colors.redAccent,
                                                            Colors.deepOrangeAccent
                                                          ],
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                        ),
                                                        borderRadius: const BorderRadius.only(
                                                          bottomRight: Radius.circular(8.0),
                                                          bottomLeft: Radius.circular(8.0),
                                                          topLeft: Radius.circular(8.0),
                                                          topRight: Radius.circular(54.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 10, left: 16, right: 16, bottom: 8),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              list[index]['name'],
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(

                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 20,
                                                                letterSpacing: 0.2,
                                                                color: Color(0xFFFFFFFF),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.only(top: 8, bottom: 8),
                                                                child: ListView.builder(
                                                                    itemCount:  list[index]['details'].length,
                                                                    itemBuilder: (context, index1) {
                                                                      return Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            "${ list[index]['details'][index1]} ",
                                                                            style: const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 12,
                                                                              letterSpacing: 0.2,
                                                                              color: Color(0xFFFFFFFF),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: <Widget>[
                                                                Text(
                                                                  list[index]['duration'],
                                                                  textAlign: TextAlign.center,
                                                                  style: const TextStyle(

                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 16,
                                                                    letterSpacing: 0.2,
                                                                    color: Color(0xFFFFFFFF),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                },
                              ),
                            );
                          }else{
                            return const CircularProgressIndicator();
                          }

                        }
                    ),
                  ),

                  CheckboxListTile(
                    value: _termsChecked,
                    onChanged: (value) {
                      setState(() {
                        _termsChecked =
                            value.toString().toLowerCase() == 'true';
                      });
                    },
                    subtitle: !_termsChecked
                        ? const Text(
                            'Required',
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          )
                        : null,
                    title: const Text(
                      'I agree to the terms and condition',
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _termsChecked) {
                              _formKey.currentState?.save();
                              p.uploadShop({
                                'owner': '$_selectedGender',
                                'Email': _email,
                                'name_en': _username,
                                'name_ar': _usernamear,
                                'address_en': address,
                                'address_ar': addressAr,
                                'lat': '${p.lat}',
                                'long': '${p.long}',
                                'desc_en': description,
                                'desc_ar': descriptionar,
                                'phone': '$_phone',
                                'phone2': '$_phone2',
                                'cat': '$idCate',
                                'data': '$_dateTime',
                                'sub':sub_Id
                              }, p.selectedFile!).whenComplete(() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Shops())));

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Form Submitted')));
                            }
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => const Shops())));
                          },
                          child: const Text('Add')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
  Widget _customPopupItemBuilderExample2(
      BuildContext context,
      UserModel? item,
      bool isSelected,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Colors.deepOrange),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        trailing: Text(item?.id ?? ''),

        title: Text(item?.name ?? ''),
        leading:  CircleAvatar(
          // this does not work - throws 404 error
          backgroundImage: NetworkImage(item?.avatar ?? ''),
        ),
      ),
    );
  }
  Widget _getImageWidget() {
    var p = Provider.of<Funcprovider>(context);

    if (p.selectedFile != null) {
      return (kIsWeb)
          ? Image.network(
              p.selectedFile!.path,
              width: (kIsWeb) ? 640 : MediaQuery.of(context).size.width - 16,
              fit: BoxFit.fill,
            )
          : Image.file(
              p.selectedFile!,
              width: (kIsWeb) ? 640 : MediaQuery.of(context).size.width - 16,
              fit: BoxFit.fill,
            );
    } else {
      return Image.network(
        'https://cdn.vectorstock.com/i/1000x1000/02/30/photo-icon-vector-21180230.webp',
        width: (kIsWeb) ? 250 : MediaQuery.of(context).size.width - 16,
        fit: BoxFit.fill,
      );
    }
  }

  validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter mail';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.toString())) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }
}
