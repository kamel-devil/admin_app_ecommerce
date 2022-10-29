import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../presentation/constant.dart';
import '../../provider/provider.dart';
import '../../res/cache_image_network.dart';
import '../../res/color_data.dart';
import '../../res/global_widget.dart';
import '../../res/shimmer_loading.dart';
import '../../sub/categoryItem.dart';
import 'edit_shop.dart';
import 'shop.dart';

class Shops extends StatefulWidget {
  const Shops({
    Key? key,
  }) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  final _globalWidget = GlobalWidget();
  TextEditingController _shopSearch = TextEditingController();
  Timer? _timerDummy;
  final _shimmerLoading = ShimmerLoading();
  bool _loading = true;
  String search = '';
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  int selectedCategoryIndex = 0;
  String idCate = '0';

  void _getData() {
    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerDummy = Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    _getData();

    super.initState();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    _shopSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    var p = Provider.of<Funcprovider>(context);
    final double boxImageSize1 = (MediaQuery.of(context).size.width / 3);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: const Text(
          'Shops List',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
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
              controller: _shopSearch,
              textAlignVertical: TextAlignVertical.bottom,
              maxLines: 1,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              onChanged: (textValue) {
                setState(() {
                  _shopSearch = TextEditingController(text: textValue);

                  search = textValue;
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: 'Search Shops',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.grey[500],
                  onPressed: () {},
                ),
                suffixIcon: (search == '')
                    ? null
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _shopSearch = TextEditingController(text: '');

                            search = '';
                          });
                        },
                        child: Icon(Icons.close, color: Colors.grey[500])),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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
                  count: 8, notifColor: BLACK77, notifSize: 24, labelSize: 14),
              //icon: _globalWidget.customNotifIcon2(8, _color1),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: 'Click notification', toastLength: Toast.LENGTH_SHORT);
              }),
        ],
      ),
      body: FutureBuilder(
        future: p.getPassengerData(isRefresh: true,search, idCate),
        builder: (context, snapshot) {
          return SmartRefresher(
            controller: p.refreshController,
            enablePullUp: true,
            onRefresh: () async {
              final result =
                  await p.getPassengerData(isRefresh: true, search, idCate);
              if (result) {
                p.refreshController.refreshCompleted();
              } else {
                p.refreshController.refreshFailed();
              }
            },
            onLoading: () async {
              final result = await p.getPassengerData(search, idCate);
              if (result) {
                p.refreshController.loadComplete();
              } else {
                p.refreshController.loadFailed();
              }
            },
            child: Column(
              children: [
                Consumer<Funcprovider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return FutureBuilder(
                        future: value.getDatacate(idCate),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && value.cate.isNotEmpty) {
                            final list = snapshot.data as List;
                            return Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        idCate = '0';
                                      });
                                    },
                                    icon: const Icon(Icons.arrow_back_ios_sharp)),
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 5, 7, 10),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        list.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.only(right: 8),
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
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  },
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Popular Shops',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: 'Click last search',
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                            child: const Text('view all',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: PRIMARY_COLOR),
                                textAlign: TextAlign.end),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: p.datapopshops(idCate,search),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && p.popshopsda.isNotEmpty) {
                            return Container(
                                margin: const EdgeInsets.only(top: 16),
                                height: boxImageSize1 * 1.90,
                                child: ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: p.popshopsda.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return _buildLastSearchCard(
                                        index, boxImageSize1);
                                  },
                                ));
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return _buildItem(boxImageSize, index);
                    },
                    itemCount: p.passengers.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildLastSearchCard(index, boxImageSize) {
    var p = Provider.of<Funcprovider>(context);

    return SizedBox(
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => shop(
                      id: p.popshopsda[index]['id'],
                    )));
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: buildCacheNetworkImage(
                      width: boxImageSize + 10,
                      height: boxImageSize + 10,
                      url: p.popshopsda[index]['image'])),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          p.popshopsda[index]['name'],
                          style: const TextStyle(
                              fontSize: 12,
                              color: BLACK77,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(
                          IconDataSolid(
                              int.parse(p.popshopsda[index]['icon_name'])),
                          color: HexColor.fromHex(p.popshopsda[index]['color']),
                          size: 15,
                        ),
                      ],
                    ),
                    Text('${p.popshopsda[index]['address']}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text('${p.popshopsda[index]['phone']}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          _globalWidget.createRatingBar(
                              rating: double.parse(
                                  '${p.popshopsda[index]['rate']['rate']}'),
                              size: 12),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                                IconDataSolid(int.parse(
                                    p.passengers[index]['icon_name'])),
                                color: HexColor.fromHex(
                                    p.passengers[index]['color']),
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
                                  child: Text(
                                      ' ${p.passengers[index]['address']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 11, color: SOFT_GREY)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                                'Phone: ${p.passengers[index]['phone']}',
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
                              showPopupDeleteFavorite(index, boxImageSize,
                                  p.passengers[index]['id']);
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
                                            id: p.passengers[index]['id'],
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

  void showPopupDeleteFavorite(index, boxImageSize, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('No', style: TextStyle(color: SOFT_BLUE)));
    Widget continueButton = TextButton(
        onPressed: () {
          delete(Uri.parse(
              'https://ibtikarsoft.net/mapapi/shop.php?lang=ar&shop=$id'));
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Shops()));
        },
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
    setState(() {
      _loading = true;
      _getData();
    });
  }
}
