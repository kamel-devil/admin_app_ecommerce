//Location
//lang

import 'package:e_commerce/Screens/shops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart' as IO;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../presentation/constant.dart';
import '../provider/provider.dart';
import '../res/color_data.dart';
import 'add_owner.dart';
import 'home_admin.dart';
import 'owners.dart';
import '../map/tools/map.dart';

class AddShop extends StatefulWidget {
  const AddShop({Key? key}) : super(key: key);

  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _usernamear = '';
  String _email = '';
  String address = '';
  String lat = "29.99738139451116";
  String long = "31.138789320917386";
  String addressAr = '';
  String description = '';
  String descriptionar = '';
  int _selectedGender = 0;
  int _phone = 011111111111;
  int _phone2 = 011111111111;
  bool _termsChecked = true;
  dynamic _selectedFile;
  bool showPh = false;
  DateTime _dateTime = DateTime.now();
  List<DropdownMenuItem<int>> genderList = [];
  String? idCate;
  String? idOwner;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);
    TextEditingController controller = TextEditingController(text: p.address);

    loadGenderList();
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
        drawer: Drawer(
            // backgroundColor: Colors.black,
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Ashish Rawat"),
              accountEmail: Text("ashishrawat2911@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("A", style: TextStyle(fontSize: 40.0)),
              ),
            ),
            ListTile(
              title: const Text('Shops'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Shops()));
              },
            ),
            ListTile(
              title: const Text('Add new shop'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddShop()));
              },
            ),
            ListTile(
              title: const Text('Owners'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Owners()));
              },
            ),
            ListTile(
              title: const Text('Add new owner'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddOwner()));
              },
            ),
          ],
        )),
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
                  FutureBuilder(
                    future: p.dataOwner(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 15,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: p.ownerData.length,
                              itemBuilder: (context, index) => ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  p.ownerData[index]['id'];
                                  setState(() {
                                    idOwner = p.ownerData[index]['id'];
                                  });
                                  print(idOwner);
                                },
                                child: Text(
                                  p.ownerData[index]['username'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  DropdownButton(
                    hint: const Text('Select '),
                    items: genderList,
                    value: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = int.parse(value.toString());
                      });
                    },
                    isExpanded: true,
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
                                        onPressed: (){

                                          p.getCurrentLocation().whenComplete(() {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(builder: (context) =>  const Map()));
                                          });
                                        },
                                        icon: const Icon(Icons.edit_location_sharp),
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
                                      controller: controller,
                                      maxLines: 2,
                                      decoration:  InputDecoration(
                                          hintText: 'العنوان',
                                          labelText: 'ادخل العنوان',
                                        suffixIcon: IconButton(
                                          onPressed: (){

                                            p.getCurrentLocation().whenComplete(() {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(builder: (context) =>  const Map()));
                                            });
                                          },
                                          icon: const Icon(Icons.edit_location_sharp),
                                        ),),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: p.cate.length,
                        itemBuilder: (context, index) => ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            p.datacate(p.cate[index]['id']);
                            setState(() {
                              idCate = p.cate[index]['id'];
                            });
                          },
                          icon: Icon(
                            IconDataSolid(
                                int.parse(p.cate[index]['icon_name'])),
                            color: HexColor.fromHex(p.cate[index]['color']),
                          ),
                          label: Text(
                            p.cate[index]['name'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
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
                          onPressed: () {

                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _termsChecked) {
                              _formKey.currentState?.save();
                              p.uploadShop({
                                'owner': '$idOwner',
                                'Email': _email,
                                'name_en': _username,
                                'name_ar': _usernamear,
                                'address_en': p.address,
                                'address_ar': addressAr,
                                'lat': lat,
                                'long': long,
                                'desc_en': description,
                                'desc_ar': descriptionar,
                                'phone': '$_phone',
                                'phone2': '$_phone2',
                                'cat': '$idCate',
                                'data': '$_dateTime',
                              }, p.file!);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Form Submitted')));

                            }
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

  Widget _getImageWidget() {
    var p = Provider.of<Funcprovider>(context);

    if (p.file != null) {
      return (kIsWeb)
          ? Image.network(
              p.file!.path,
              width: (kIsWeb) ? 640 : MediaQuery.of(context).size.width - 16,
              fit: BoxFit.fill,
            )
          : Image.file(
              p.file!,
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
