import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../presentation/constant.dart';

import '../../provider/provider.dart';
import '../../res/cache_image_network.dart';
import '../../res/color_data.dart';
import '../../res/global_widget.dart';
import '../../res/shimmer_loading.dart';
import '../Shops/edit_shop.dart';
import '../Shops/shop.dart';
import '../home_admin.dart';

class Owner extends StatefulWidget {
  Owner({required this.id});
  String id;
  @override
  State<Owner> createState() => _OwnerState();
}

class _OwnerState extends State<Owner> {
  final _globalWidget = GlobalWidget();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Timer? _timerDummy;
  TextEditingController _etSearch = TextEditingController();
  final _shimmerLoading = ShimmerLoading();
  bool _loading = true;
  String search = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    _etSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    final double boxImageSize = (MediaQuery.of(context).size.width / 4);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homeAdmin()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          title: const Text(
            'Owner',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          // create search text field in the app bar
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey[100]!,
                  width: 1.0,
                )),
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              height: kToolbarHeight,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                onChanged: (textValue) {
                  setState(() {
                    search = textValue;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: 'Search shop',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  suffixIcon: (search == '')
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              search = '';
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey[500])),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey[200]!)),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: 'Click message', toastLength: Toast.LENGTH_SHORT);
                },
                child: const Icon(Icons.email, color: BLACK77)),
            IconButton(
                icon: _globalWidget.customNotifIcon(
                    count: 8,
                    notifColor: BLACK77,
                    notifSize: 24,
                    labelSize: 14),
                //icon: _globalWidget.customNotifIcon2(8, _color1),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: 'Click notification',
                      toastLength: Toast.LENGTH_SHORT);
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: p.dataOwner(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Card(
                    elevation: 2,
                    child: SizedBox(
                      width: double.infinity,
                      height: 156,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Preferred Merchants',
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: const Icon(Icons.edit,
                                        size: 20, color: BLACK77)),
                              ],
                            ),
                          ),
                          Row(children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://www.alwatan.com.sa/uploads/images/2019/10/18/402490.jpg')),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Text(
                                  //         'Preferred Merchants',
                                  //       ),
                                  //       GestureDetector(
                                  //           onTap: () {},
                                  //           child: Icon(Icons.info_outline,
                                  //               size: 20, color: BLACK77)),
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child:  Text(
                                        '${p.ownerEdit['f_name']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: const Text(
                                      'Address',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.star,
                                            color: Colors.orange, size: 15),
                                        SizedBox(width: 2),
                                        Text(
                                          '4.9',
                                        ),
                                        SizedBox(width: 6),
                                        Icon(Icons.location_pin,
                                            color: ASSENT_COLOR, size: 15),
                                        SizedBox(width: 2),
                                        Text(
                                          '0.7 miles',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SmartRefresher(
                      controller: p.refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        print('RRRRRRRRRRRRRRRRRRR============');

                        final result = await p.getPassengerData(
                            isRefresh: true, '', '0');
                        if (result) {
                          p.refreshController.refreshCompleted();
                        } else {
                          p.refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        print('loading============');
                        final result = await p.getPassengerData('', '0');
                        if (result) {
                          p.refreshController.loadComplete();
                        } else {
                          p.refreshController.loadFailed();
                        }
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        // key: _listKey,
                        // physics: AlwaysScrollableScrollPhysics (),
                        itemBuilder: (context, index) {
                          return _buildItem(boxImageSize, index);
                        },
                        itemCount: p.passengers.length,

                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                      ),
                    ),
                  ),
                ]);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }

  Widget _buildItem(boxImageSize, index) {
    var p = Provider.of<Funcprovider>(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => shop(
                        id: p.passengers[index]['id'],
                      )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        child: buildCacheNetworkImage(
                            width: boxImageSize,
                            height: boxImageSize,
                            url: p.passengers[index]['image'])),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                p.passengers[index]['name'],
                                style: const TextStyle(
                                    fontSize: 13, color: color2),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(
                                IconDataSolid(
                                    int.parse(p.passengers[index]['icon_name'])),
                                color:
                                HexColor.fromHex(p.passengers[index]['color']),
                                size: 15,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: SOFT_GREY, size: 12),
                                Flexible(
                                  child: Text(' ${p.passengers[index]['address']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 11, color: SOFT_GREY)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text('Phone: ${p.passengers[index]['phone']}',
                                style: const TextStyle(
                                    fontSize: 11, color: SOFT_GREY)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                _globalWidget.createRatingBar(
                                    rating: double.parse(
                                        '${p.passengers[index]['rate']['rate']}'),
                                    size: 12),
                                Text(
                                    '   (${p.passengers[index]['rate']['count']})'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              p.passengers[index]['is_edit']
                  ? Container(
                margin: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 1, color: Colors.grey[300]!)),
                        child: const Icon(Icons.delete,
                            color: BLACK77, size: 20),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditShop(
                                  id:  p.passengers[index]['id'],

                                )));
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(0, 30)),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.transparent),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                    color: SOFT_BLUE, width: 1.0),
                              )),
                          child: const Text(
                            'EDIT',
                            style: TextStyle(
                                color: SOFT_BLUE,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              )
                  : const Text('')
            ],
          ),
        ),
      ),
    );
  }

  void showPopupDeleteFavorite(index, boxImageSize) {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('No', style: TextStyle(color: SOFT_BLUE)));
    Widget continueButton = TextButton(
        onPressed: () {},
        child: const Text('Yes', style: TextStyle(color: SOFT_BLUE)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Delete Shops',
        style: TextStyle(fontSize: 18),
      ),
      content: const Text('Are you sure to delete this item from your Shops ?',
          style: TextStyle(fontSize: 13, color: BLACK77)),
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

  Future refreshData() async {
    setState(() {});
  }
}
