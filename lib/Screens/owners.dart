import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../presentation/constant.dart';

import '../provider/provider.dart';
import '../res/cache_image_network.dart';
import '../res/global_widget.dart';
import 'home_admin.dart';

class Owners extends StatefulWidget {
  const Owners({Key? key}) : super(key: key);

  @override
  State<Owners> createState() => _OwnersState();
}

class _OwnersState extends State<Owners> {
  final _globalWidget = GlobalWidget();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Timer? _timerDummy;
  TextEditingController _etSearch = TextEditingController();

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
            icon: Icon(Icons.arrow_back),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          title: const Text(
            'Owner List',
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
                controller: _etSearch,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                onChanged: (textValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: 'Search owner',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  suffixIcon: (_etSearch.text == '')
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _etSearch = TextEditingController(text: '');
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
                  // Card(
                  //   elevation: 2,
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     height: 156,
                  //     child: Column(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               const Text(
                  //                 'Preferred Merchants',
                  //               ),
                  //               GestureDetector(
                  //                   onTap: () {},
                  //                   child: const Icon(Icons.info_outline,
                  //                       size: 20, color: BLACK77)),
                  //             ],
                  //           ),
                  //         ),
                  //         Row(children: [
                  //           Container(
                  //             width: 120,
                  //             height: 120,
                  //             decoration: const BoxDecoration(
                  //               image: DecorationImage(
                  //                   fit: BoxFit.cover,
                  //                   image: NetworkImage(
                  //                       'https://www.alwatan.com.sa/uploads/images/2019/10/18/402490.jpg')),
                  //             ),
                  //           ),
                  //           Expanded(
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 // Container(
                  //                 //   child: Row(
                  //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 //     children: [
                  //                 //       Text(
                  //                 //         'Preferred Merchants',
                  //                 //       ),
                  //                 //       GestureDetector(
                  //                 //           onTap: () {},
                  //                 //           child: Icon(Icons.info_outline,
                  //                 //               size: 20, color: BLACK77)),
                  //                 //     ],
                  //                 //   ),
                  //                 // ),
                  //                 Container(
                  //                   margin: const EdgeInsets.symmetric(horizontal: 16),
                  //                   child: const Text(
                  //                       'Steam Boat Lovers - Lefferts Avenue',
                  //                       style: TextStyle(fontWeight: FontWeight.bold),
                  //                       maxLines: 2,
                  //                       overflow: TextOverflow.ellipsis),
                  //                 ),
                  //                 const SizedBox(height: 4),
                  //                 Container(
                  //                   margin: const EdgeInsets.symmetric(horizontal: 16),
                  //                   child: const Text(
                  //                     'Address',
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 8),
                  //                 Container(
                  //                   margin: const EdgeInsets.symmetric(horizontal: 16),
                  //                   child: Row(
                  //                     children: const [
                  //                       Icon(Icons.star,
                  //                           color: Colors.orange, size: 15),
                  //                       SizedBox(width: 2),
                  //                       Text(
                  //                         '4.9',
                  //                       ),
                  //                       SizedBox(width: 6),
                  //                       Icon(Icons.location_pin,
                  //                           color: ASSENT_COLOR, size: 15),
                  //                       SizedBox(width: 2),
                  //                       Text(
                  //                         '0.7 miles',
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         ]),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  RefreshIndicator(
                    onRefresh: refreshData,
                    child: Container(
                      height: 700,
                      child: AnimatedList(
                          shrinkWrap: true,
                          key: _listKey,
                          initialItemCount: p.ownerData.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index, animation) {
                            return _buildItem(boxImageSize, animation, index);
                          }),
                    ),
                  )
                ]);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }

  Widget _buildItem(boxImageSize, animation, index) {
    var p = Provider.of<Funcprovider>(context);

    return SizeTransition(
      sizeFactor: animation,
      child: Container(
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
                  onTap: () {},
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
                              url: p.ownerData[index]['image'])),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.ownerData[index]['username'],
                              style:
                                  const TextStyle(fontSize: 13, color: color2),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  p.ownerData[index]['f_name'],
                                  style: const TextStyle(
                                      fontSize: 13, color: color2),
                                ),
                                Text(
                                  p.ownerData[index]['l_name'],
                                  style: const TextStyle(
                                      fontSize: 13, color: color2),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                  'Phone: ${p.ownerData[index]['phone']}',
                                  style: const TextStyle(
                                      fontSize: 11, color: SOFT_GREY)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          showPopupDeleteFavorite(index, boxImageSize);
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
                              Fluttertoast.showToast(msg: 'Item has been EDIT');
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
              ],
            ),
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
