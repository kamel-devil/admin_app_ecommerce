import 'dart:math';

import 'package:e_commerce/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import '../presentation/constant.dart';







class homeAdmin extends StatefulWidget {
  @override
  State<homeAdmin> createState() => _homeAdminState();
}

class _homeAdminState extends State<homeAdmin> {
  final _globalWidget = GlobalWidget();


  late PageController _pageController;

  List data=[['2014',5,38],['2015',12,15]];
  final List<Sales> _smartphoneData = [
    Sales("2014", 5),
    Sales("2015", 12),
    Sales("2016", 14),
    Sales("2017", 17),
    Sales("2018", 8),
    Sales("2019", 11),
    Sales("2020", 26),
  ];

  final List<Sales> _refrigeratorData = [
    Sales("2014", 30),
    Sales("2015", 15),
    Sales("2016", 18),
    Sales("2017", 27),
    Sales("2018", 18),
    Sales("2019", 9),
    Sales("2020", 37),
  ];

  List<charts.Series<Sales, String>> series=[];

  // final List<Sales> _tvData = [
  //   Sales("2014", 80),
  //   Sales("2015", 170),
  //   Sales("2016", 160),
  //   Sales("2017", 220),
  //   Sales("2018", 120),
  //   Sales("2019", 150),
  //   Sales("2020", 310),
  // ];

  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Statistics',
          style:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),

        // leading:
        //
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.arrow_back_ios_new_outlined),color: Colors.black,),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.person),
            color: Colors.black,
          ),
        ],
      ),
      // drawer: Drawer(
      //   // backgroundColor: Colors.black,
      //     child: ListView(
      //       padding: EdgeInsets.zero,
      //       children: <Widget>[
      //         const UserAccountsDrawerHeader(
      //           accountName: Text("Ashish Rawat"),
      //           accountEmail: Text("ashishrawat2911@gmail.com"),
      //           currentAccountPicture: CircleAvatar(
      //             backgroundColor: Colors.white,
      //             child: Text("A", style: TextStyle(fontSize: 40.0)),
      //           ),
      //         ),
      //         ListTile(
      //           title: const Text('Shops'),
      //           trailing: const Icon(Icons.arrow_forward),
      //           onTap: () {
      //
      //           },
      //         ),
      //         ListTile(
      //           title: const Text('product'),
      //           onTap: () {
      //             showDialog(
      //                 barrierDismissible: false,
      //                 context: context,
      //                 builder: (_) {
      //                   return Dialog(
      //                     // The background color
      //                     backgroundColor: Colors.white,
      //                     child: Padding(
      //                       padding: const EdgeInsets.symmetric(vertical: 20),
      //                       child: Column(
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: const [
      //                           // The loading indicator
      //                           CircularProgressIndicator(),
      //                           SizedBox(
      //                             height: 15,
      //                           ),
      //                           // Some text
      //                           Text('Loading...')
      //                         ],
      //                       ),
      //                     ),
      //                   );
      //                 });
      //
      //
      //           },
      //         ),
      //         ListTile(
      //           title: const Text('suplaiers'),
      //           onTap: () {
      //
      //           },
      //         ),
      //         ListTile(
      //           title: const Text('Customer'),
      //           onTap: () {
      //           },
      //         ),
      //       ],
      //     )),
      body:FutureBuilder(
        future: p.getFavServices(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            final list = snapshot.data as List;
            series.add(charts.Series(
                id: 'count',
                domainFn: (Sales sales, _) => sales.year,
                measureFn: (Sales sales, _) => sales.sale,
                data: p.smartphoneData
            ));

            return  SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _globalWidget.createDetailWidget(
                      title: 'Bar Charts 1 (Simple Bar Charts)',
                      desc: 'This is the example of simple bar charts'),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 400,
                      child: charts.BarChart(
                          series,
                          barGroupingType: charts.BarGroupingType.grouped,
                          behaviors: [
                            charts.SeriesLegend(
                              // By default, if the position of the chart is on the left or right of
                              // the chart, [horizontalFirst] is set to false. This means that the
                              // legend entries will grow as new rows first instead of a new column.
                              horizontalFirst: false,
                              // By setting this value to 2, the legend entries will grow up to two
                              // rows before adding a new column.
                              desiredMaxRows: 2,
                              // This defines the padding around each legend entry.
                              cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                              // Render the legend entry text with custom styles.
                              entryTextStyle: const charts.TextStyleSpec(
                                  color: charts.Color(r: 127, g: 63, b: 191),
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ]
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 0),
                  //   child: Row(
                  //     children: [
                  //       IconButton(
                  //         onPressed: () {},
                  //         icon: Icon(Icons.home),color: Colors.black,),
                  //
                  //     ],
                  //   ),
                  // )
                ],
              ),
            );
          }else{
            return const CircularProgressIndicator();
          }
        },
      ),
      //   bottomNavigationBar: ConvexAppBar(
      //   style: TabStyle.react,
      //   backgroundColor: Colors.white,
      //   items: [
      //     TabItem(icon: IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.home),color: Colors.black,), title: 'Nav 4'),
      //     TabItem(icon:    IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.line_weight_outlined),color: Colors.black,), title: 'Nav 4'),
      //   ],
      //   initialActiveIndex: 0,//optional, default as 0
      //   onTap: (int i){
      //     _tapNav(i);
      //   },
      // ),
    );
  }
}

class Sales {
  final String year;
  final int sale;

  Sales(this.year, this.sale);
}

class GlobalWidget{
  final Random _random = Random();

  // create random color for polylines
  Color _getColor() {
    return Color.fromARGB(
        255, _random.nextInt(255), _random.nextInt(255), _random.nextInt(255));
  }

  final List<IconData> _iconList = [
    Icons.star_rate,
    Icons.code,
    Icons.adb,
    Icons.android,
    Icons.select_all,
    Icons.eco,
    Icons.label_important,
    Icons.album,
    Icons.scatter_plot,
    Icons.memory,
    Icons.audiotrack,
    Icons.miscellaneous_services,
    Icons.whatshot
  ];

  PreferredSizeWidget globalAppBar(){
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      title: Image.asset('assets/images/logo_horizontal.png', height: 24),
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey[100],
            height: 1.0,
          ),
          preferredSize: const Size.fromHeight(1.0)),
    );
  }

  Widget screenTabList({required BuildContext context, required int id, required String title, required IconData icon, String? desc, required StatefulWidget page}){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: const EdgeInsets.only(top:16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 20,
                child: Text(id.toString())
            ),
            const SizedBox(width: 24),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 2,
                color: Colors.white,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(icon, color: _getColor()),
                )
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400
                    )),
                    const SizedBox(height: 4),
                    (desc==null)?Wrap():Text(desc, style: TextStyle(
                        fontSize: 12, color: Colors.grey[700]
                    )),
                    (desc==null)?Wrap():const SizedBox(height: 4),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget screenDetailList({required BuildContext context, required String title, required StatefulWidget page}){
    Color color = _getColor();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          elevation: 0.5,
          child: Container(
            margin: const EdgeInsets.all(18),
            child: Row(
              children: [
                Icon(_iconList[_random.nextInt(_iconList.length)], color: color, size: 26),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(title, style: const TextStyle(
                      fontSize: 16, color: BLACK55, fontWeight: FontWeight.w500
                  )),
                ),
                Icon(Icons.chevron_right, size: 30, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createDetailWidget({required String title, required String desc}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(title, style: const TextStyle(
              fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
          )),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Container(
            child: Text(desc, style: const TextStyle(
                fontSize: 15, color: BLACK77,letterSpacing: 0.5
            )),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 24, bottom: 8),
          child: Text('Example'.tr, style: const TextStyle(
              fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
          )),
        ),
      ],
    );
  }

  Widget createDetailWidget2({required String title, required String desc, required IconData icon}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(title, style: const TextStyle(
              fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
          )),
        ),
        Container(
          margin: const EdgeInsets.only(top: 24),
          child: Row(
            children: [
              Flexible(
                  flex:5,
                  child: Container(
                    child: Text(desc, style: const TextStyle(
                        fontSize: 15, color: BLACK77,letterSpacing: 0.5
                    )),
                  )
              ),
              Flexible(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      child: Icon(icon, size: 50, color: SOFT_BLUE))
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 24, bottom: 16),
          child: Text('Example'.tr, style: const TextStyle(
              fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
          )),
        ),
      ],
    );
  }

  Widget createButton({Color backgroundColor = Colors.blue, Color textColor = Colors.white, required String buttonName, required Function onPressed,}){
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => backgroundColor,
          ),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              )
          ),
        ),
        onPressed: onPressed as void Function(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            buttonName,
            style: TextStyle(
                fontSize: 14,
                color: textColor),
            textAlign: TextAlign.center,
          ),
        )
    );
  }

  Widget createDefaultLabel(context){
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
          color: SOFT_BLUE,
          borderRadius: BorderRadius.circular(2)
      ),
      child: Row(
        children: [
          const Text('Default', style: TextStyle(
              color: Colors.white, fontSize: 13
          )),
          const SizedBox(
            width: 4,
          ),
          const Icon(Icons.done, color: Colors.white, size: 11)
        ],
      ),
    );
  }

  Widget createRatingBar({double rating=5, double size=24}){
    if(rating < 0){
      rating = 0;
    } else if(rating>5){
      rating = 5;
    }

    bool _absolute = false;
    int _fullStar = 0;
    int _emptyStar = 0;

    if(rating == 0 || rating == 1 || rating == 2 || rating == 3 || rating == 4 || rating == 5){
      _absolute = true;
    } else {
      double _dec = (rating - int.parse(rating.toString().substring(0,1)));
      if(_dec > 0 && _dec < 1){
        if(_dec >= 0.25 && _dec <= 0.75){
          _absolute = false;
        } else {
          _absolute = true;
          if(_dec < 0.25){
            _emptyStar = 1;
          } else if(_dec > 0.75){
            _fullStar = 1;
          }
        }
      }
    }
    return Row(
      children: [
        for(int i=1;i<=rating+_fullStar;i++) Icon(Icons.star, color: Colors.yellow[700], size: size),
        !_absolute?Icon(Icons.star_half, color: Colors.yellow[700], size: size):const SizedBox.shrink(),
        for(int i=1;i<=(5-rating+_emptyStar);i++) Icon(Icons.star_border, color: Colors.yellow[700], size: size),
      ],
    );
  }

  Widget customNotifIcon({int count=0, Color notifColor=Colors.grey, Color labelColor=Colors.pinkAccent, double notifSize=24, double labelSize=14, String position='right'}) {
    double? posLeft;
    double? posRight = 0;
    if(position == 'left'){
      posLeft = 0;
      posRight = null;
    }
    return Stack(
      children: <Widget>[
        Icon(Icons.notifications, color: notifColor, size: notifSize),
        Positioned(
          left: posLeft,
          right: posRight,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: labelColor,
              borderRadius: BorderRadius.circular(labelSize),
            ),
            constraints: BoxConstraints(
              minWidth: labelSize,
              minHeight: labelSize,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildProgressIndicator(lastData) {
    if(lastData==false){
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
            opacity: 1,
            child: new Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(5),
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
                strokeWidth: 2.0,
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}