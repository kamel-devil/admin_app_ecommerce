
import 'package:e_commerce/Screens/home_admin.dart';
import 'package:flutter/material.dart';

import '../Screens/Owner/add_owner.dart';
import '../Screens/Owner/owners.dart';
import '../Screens/Shops/shops.dart';
import '../Screens/ranking/leader_bord_screen.dart';
import '../map/tools/map.dart';
import 'app_theme.dart';
import 'drawer_user_controller.dart';
import 'home_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView =  LeaderBoardScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:

          setState(() {
            screenView =  LeaderBoardScreen();
          });
          break;
        case DrawerIndex.Shops:
          setState(() {
            screenView = const Shops();
          });
          break;
        case DrawerIndex.Owners:
          setState(() {
            screenView = const Owners();
          });
          break;
        case DrawerIndex.AddOwner:
          setState(() {
            screenView = AddOwner();
          });
          break;
        case DrawerIndex.AddShop:
          setState(() {
            screenView = const Map1();
          });
          break;

        default:
          break;
      }
    }
  }
}
