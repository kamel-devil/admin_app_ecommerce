import 'dart:io';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart' as IO;
import 'package:flutter/material.dart';
import '../../provider/provider.dart';
import '../Shops/add_shop.dart';
import '../home_admin.dart';
import 'add_owner.dart';
import 'owners.dart';

class Editowner extends StatefulWidget {
  Editowner({required this.id});
  String id;

  @override
  _EditownerState createState() => _EditownerState();
}

class _EditownerState extends State<Editowner> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _f_name = '';
  String _l_name = '';
  String _username = '';
  String _email = '';
  int _phone = 011111111111;
  String _password = '';
  bool _termsChecked = true;
  File? _selectedFile;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      value: 0,
      child: Text('Male'),
    ));
    genderList.add(const DropdownMenuItem(
      value: 1,
      child: Text('Female'),
    ));
    genderList.add(const DropdownMenuItem(
      value: 2,
      child: Text('Others'),
    ));
  }

  @override
  void dispose() {
    if (_selectedFile != null && _selectedFile!.existsSync()) {
      _selectedFile!.deleteSync();
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

    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,

          title: const Text(
            'Edit Owner',
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
              onTap: () {},
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
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: p.editOwner(id: widget.id),
            builder: (context, snapshot) {
          if (snapshot.hasData) {
            final map=snapshot.data as Map;
            TextEditingController fNameController =
            TextEditingController(text: map['f_name']);
            TextEditingController lNameController =
            TextEditingController(text: map['l_name']);
            TextEditingController phoneController =
            TextEditingController(text: map['phone']);
            TextEditingController userNameController =
            TextEditingController(text: map['username']);
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    p.selectedFile == null
                        ? CircleAvatar(
                            radius: 83,
                            backgroundColor: Color(0xff14be77),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: ResizeImage(
                                  NetworkImage(map['image']),
                                  width: 120,
                                  height: 120),
                            ),
                          )
                        : CircleAvatar(
                            radius: 83,
                            backgroundColor: const Color(0xff14be77),
                            child: CircleAvatar(
                              radius: 80,
                              // child: ClipRect(
                              //   child: Image.file(p.file!),
                              // ),
                              //  backgroundImage:FileImage(p.file!),
                              backgroundImage: ResizeImage(FileImage(p.selectedFile!),
                                  width: 120, height: 120),
                            ),
                          ),
                    IconButton(
                        onPressed: () {
                          showPopupDeleteFavorite(context);
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xffFD8F11),
                          ),
                        )),
                    TextFormField(
                      controller: fNameController,
                      decoration: const InputDecoration(
                          labelText: 'Enter First Name',
                          hintText: 'First Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a First name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _f_name = value.toString();
                        });
                      },
                    ),
                    TextFormField(
                      controller: lNameController,
                      decoration: const InputDecoration(
                          labelText: 'Enter Last Name',
                          hintText: 'Last Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a last name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _l_name = value.toString();
                        });
                      },
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
                      controller: phoneController,
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
                    TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          hintText: 'Admin@mail.com', labelText: 'User Name'),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter user name';
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
                        key: _passKey,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            labelText: 'Enter Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter password';
                          } else if (value.length < 8) {
                            return 'Password should be more than 8 characters';
                          } else {
                            return null;
                          }
                        }),
                    TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            labelText: 'Enter Confirm Password'),
                        validator: (confirmPassword) {
                          if (confirmPassword != null &&
                              confirmPassword.isEmpty) {
                            return 'Enter confirm password';
                          }
                          var password = _passKey.currentState?.value;
                          if (confirmPassword != null &&
                              confirmPassword.compareTo(password) != 0) {
                            return 'Password mismatch';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            _password = value.toString();
                          });
                        }),
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
                              style: TextStyle(
                                  color: Colors.red, fontSize: 12.0),
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
                            onPressed: () {},
                            // onPressedSubmit,
                            child: const Text('cancel')),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _termsChecked) {
                                _formKey.currentState?.save();
                                p.updateOwner(
                                    data: {
                                      'f_name': _f_name,
                                      'l_name': _l_name,
                                      'email': _email,
                                      'username': _username,
                                      'phone': '$_phone',
                                      'password': _password
                                    },
                                    file: p.selectedFile != null ? p.selectedFile!.path : map['image'],
                                    id: widget.id).whenComplete(() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Owners())));

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Form Submitted')));
                              }

                            },
                            child: const Text('Add')),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
            },
          ),
        ));
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

  void showPopupDeleteFavorite(BuildContext context) {
    var p = Provider.of<Funcprovider>(context, listen: false);

    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          p.askPermissionCamera();
        },
        child: const Text('Camera', style: TextStyle(color: Colors.black)));
    Widget continueButton = TextButton(
        onPressed: () {
          if (IO.Platform.isAndroid) {
            p.askPermissionPhotos();
          } else {
            p.askPermissionStorage();
          }
        },
        child: const Text('Gallery', style: TextStyle(color: Colors.black)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'image',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
