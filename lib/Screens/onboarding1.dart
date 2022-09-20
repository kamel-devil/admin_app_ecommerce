import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../presentation/constant.dart';
import '../flutter_overboard/overboard.dart';
import '../flutter_overboard/page_model.dart';

class Onboarding1Page extends StatefulWidget {
  @override
  _Onboarding1PageState createState() => _Onboarding1PageState();
}

class _Onboarding1PageState extends State<Onboarding1Page> {
  // create each page of onBoard here
  final _pageList = [
    PageModel(
        color: Colors.white,
        imageFromUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0FM_KF_IvO7vVzkBAHdgJsr5S0Z_IN8DKGw&usqp=CAU',
        title: 'Tutorial 1',
        body: 'This is description of tutorial 1. Lorem ipsum dolor sit amet.',
        doAnimateImage: true),
    PageModel(
        color: Colors.white,
        imageFromUrl:
            'https://www.dior.com/couture/var/dior/storage/images/horizon/fragrance/mens-fragrance/sauvage/01-sauvage-elixir-20213/29604254-2-eng-US/01-sauvage-elixir-20212_1440_1200.jpg',
        title: 'Tutorial 2',
        body: 'This is description of tutorial 2. Lorem ipsum dolor sit amet.',
        doAnimateImage: true),
    PageModel(
        color: Colors.white,
        imageFromUrl:
            'https://eco-beauty.dior.com/dw/image/v2/BDGF_PRD/on/demandware.static/-/Sites-master_dior/default/dw62f926d0/assets/Y0996170/Y0996170_E03_GHC.jpg?sw=715&sh=773&sm=fit&imwidth=800',
        title: 'Tutorial 3',
        body: 'This is description of tutorial 3. Lorem ipsum dolor sit amet.',
        doAnimateImage: true),
    PageModel(
        color: Colors.white,
        imageFromUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYtkYsJZku4Al12weWQ3kBHSOLTi4AWPWujA&usqp=CAU',
        title: 'Tutorial 4',
        body: 'This is description of tutorial 4. Lorem ipsum dolor sit amet.',
        doAnimateImage: true),
  ];

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
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: OverBoard(
        pages: _pageList,
        showBullets: true,
        finishCallback: () {
          Fluttertoast.showToast(
              msg: 'Click finish', toastLength: Toast.LENGTH_SHORT);
        },
      ),
    ));
  }
}
