import 'package:e_commerce/register/signin2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../classes/language.dart';
import '../classes/language_constants.dart';
import '../custom_drawer/navigation_home_screen.dart';
import '../main.dart';
import '../presentation/constant.dart';
import '../provider/provider.dart';
import '../res/cache_image_network.dart';

class User1Page extends StatefulWidget {
  @override
  _User1PageState createState() => _User1PageState();
}

class _User1PageState extends State<User1Page> {
  Color _color1 = const Color(0xff777777);
  Color _color2 = const Color(0xFF515151);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double profilePictureSize = MediaQuery.of(context).size.width / 4;
    var p = Provider.of<Funcprovider>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            'Account',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: 'Click message', toastLength: Toast.LENGTH_SHORT);
                },
                child: Icon(Icons.email, color: _color1)),
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: _color1,
                ),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: 'Click notification',
                      toastLength: Toast.LENGTH_SHORT);
                }),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey[100],
                height: 1.0,
              )),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            FutureBuilder(
                future: p.getDataUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && p.userData.isNotEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: profilePictureSize,
                            height: profilePictureSize,
                            child: GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: 'Click picture',
                                    toastLength: Toast.LENGTH_SHORT);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: profilePictureSize,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: profilePictureSize - 4,
                                  child: Hero(
                                    tag: 'profilePicture',
                                    child: ClipOval(
                                        child: buildCacheNetworkImage(
                                            width: profilePictureSize - 4,
                                            height: profilePictureSize - 4,
                                            url: p.userData['image'])),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' ${p.userData['f_name'] + p.userData['l_name']}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Click account information / user profile',
                                        toastLength: Toast.LENGTH_SHORT);
                                  },
                                  child: Row(
                                    children: [
                                      Text('Account Information',
                                          style: TextStyle(
                                              fontSize: 14, color: _color1)),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(Icons.chevron_right,
                                          size: 20, color: SOFT_GREY)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            _createListMenu('Change Password'),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu('Set Address'),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu('Owners'),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu('Shops'),
            Divider(height: 0, color: Colors.grey[400]),
            DropdownButton<Language>(
              iconSize: 30,
              hint: Text(translation(context).changeLanguage),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale _locale = await setLocale(language.languageCode);
                  MyApp.setLocale(context, _locale);
                  p.changeLang(_locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  p.clearData().whenComplete(() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Signin2Page())));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.power_settings_new,
                        size: 20, color: ASSENT_COLOR),
                    SizedBox(width: 8),
                    Text('Sign Out',
                        style: TextStyle(fontSize: 15, color: ASSENT_COLOR)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _createListMenu(String menuTitle) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Fluttertoast.showToast(
            msg: 'Click $menuTitle', toastLength: Toast.LENGTH_SHORT);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(menuTitle, style: TextStyle(fontSize: 15, color: _color2)),
            const Icon(Icons.chevron_right, size: 20, color: SOFT_GREY),
          ],
        ),
      ),
    );
  }
}
