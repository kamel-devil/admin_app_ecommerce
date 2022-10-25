import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/sales_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../profile/user1.dart';
import '../res/global_widget.dart';

class homeAdmin extends StatefulWidget {
  @override
  State<homeAdmin> createState() => _homeAdminState();
}

class _homeAdminState extends State<homeAdmin> {
  final _globalWidget = GlobalWidget();

  late var _series;
  late PageController _pageController;

  final List<Sales> _data = [
    Sales("2014", 5),
    Sales("2015", 10),
    Sales("2016", 15),
    Sales("2017", 20),
    Sales("2018", 13),
    Sales("2019", 11),
    Sales("2020", 9),
  ];

  @override
  void initState() {
    _series = [
      charts.Series(
          id: "Sales",
          domainFn: (Sales sales, _) => sales.year,
          measureFn: (Sales sales, _) => sales.sale,
          data: _data)
    ];
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => (User1Page())));
            },
            icon: const Icon(Icons.person),
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
      //         Navigator.of(context)
      //             .push(MaterialPageRoute(builder: (context) =>  Shops()));
      //       },
      //     ),
      //     ListTile(
      //       title: const Text('Add new shop'),
      //       onTap: () {
      //         showDialog(
      //             barrierDismissible: false,
      //             context: context,
      //             builder: (_) {
      //               return Dialog(
      //                 // The background color
      //                 backgroundColor: Colors.white,
      //                 child: Padding(
      //                   padding: const EdgeInsets.symmetric(vertical: 20),
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: const [
      //                       // The loading indicator
      //                       CircularProgressIndicator(),
      //                       SizedBox(
      //                         height: 15,
      //                       ),
      //                       // Some text
      //                       Text('Loading...')
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             });
      //
      //         p.getCurrentLocation().whenComplete(() {
      //           Navigator.of(context)
      //               .push(MaterialPageRoute(builder: (context) => const Map()));
      //         });
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
      body: SingleChildScrollView(
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
                  _series,
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
