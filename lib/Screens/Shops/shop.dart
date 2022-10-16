import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/constant.dart';
import '../../provider/provider.dart';
import '../../res/cache_image_network.dart';
import '../../res/reusable_widget.dart';
import '../../sub/meals_list_view.dart';

class shop extends StatelessWidget {
  shop({
    Key? key,
    required this.id,
  }) : super(key: key);

  String id;

  final _reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: p.datashop(id:id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(p.shopda['image'])),
                      ),
                    ),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Preferred Merchants',
                                  ),
                                  p.shopda['is_edit'] ==true?
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.edit,
                                          size: 20, color: BLACK77)):
                                      const Text('')
                                ],
                              ),
                            ),
                            Row(children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(p.shopda['image'])),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(p.shopda['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            p.shopda['address'],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(p.shopda['phone']),
                                              GestureDetector(
                                                  onTap: () {
                                                    launchUrl(Uri.parse('tel:/${p.shopda['phone']}'));
                                                  },
                                                  child: const Icon(Icons.phone,
                                                      size: 20, color: BLACK77)),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.orange, size: 15),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${p.shopda['rate']['rate']}',
                                          ),
                                          Text(
                                            '(${p.shopda['rate']['count']})',
                                          ),
                                          const SizedBox(width: 30),
                                          const Icon(Icons.location_pin,
                                              color: ASSENT_COLOR, size: 15),
                                          const SizedBox(width: 80,),
                                          const Icon(Icons.favorite,
                                              color: ASSENT_COLOR, size: 15),
                                          const SizedBox(width: 2),
                                          Text(
                                            '(${p.shopda['fav']})',
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
                    p.shopda['owner'] != null?Card(
                      elevation: 2,
                      child: SizedBox(
                        width: double.infinity,
                        height: 156,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Preferred Merchants',
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse('tel:/${p.shopda['owner']['phone']}'));
                                      },
                                      child: const Icon(Icons.phone,
                                          size: 20, color: BLACK77)),
                                ],
                              ),
                            ),
                            Row(children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(p.shopda['owner']['image'])),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(p.shopda['owner']['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        children: [
                                          Text('phone:${p.shopda['owner']['phone']}'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ) //owner
                            ]),
                          ],
                        ),
                      ),
                    ):Container(),
                    const SizedBox(
                      height: 5,
                    ), //owner


                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(Icons.local_offer_outlined,
                                color: ASSENT_COLOR, size: 16),
                            SizedBox(width: 4),
                            Text('Check for available coupons'),
                            Spacer(),
                            Text(
                              'See Coupons',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Stack(
                    //   children: [
                    //     CarouselSlider(
                    //       items: p.shopda['gallery']
                    //           .map((item) => GestureDetector(
                    //               onTap: () {
                    //               },
                    //               child: buildCacheNetworkImage(
                    //                   width: 0, height: 0, url: item)))
                    //           .toList(),
                    //       options: CarouselOptions(
                    //           aspectRatio: 2,
                    //           viewportFraction: 1.0,
                    //           autoPlay: true,
                    //           autoPlayInterval: const Duration(seconds: 6),
                    //           autoPlayAnimationDuration:
                    //               const Duration(milliseconds: 300),
                    //           enlargeCenterPage: false,
                    //           onPageChanged: (index, reason) {}),
                    //     ),
                    //     Positioned(
                    //       bottom: 0,
                    //       left: 0,
                    //       right: 0,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: p.shopda['gallery'].map((item) {
                    //           int index = p.shopda['gallery'].indexOf(item);
                    //           return AnimatedContainer(
                    //             duration: const Duration(milliseconds: 150),
                    //             width: _currentImageSlider == index ? 10 : 5,
                    //             height: _currentImageSlider == index ? 10 : 5,
                    //             margin: const EdgeInsets.symmetric(
                    //                 vertical: 10.0, horizontal: 4.0),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               color: Colors.white,
                    //             ),
                    //           );
                    //         }).toList(),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Gallery',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
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
                        Container(
                            margin: const EdgeInsets.only(top: 16),
                            height: boxImageSize * 1.15,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              scrollDirection: Axis.horizontal,
                              itemCount: p.shopda['gallery'].length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  width: boxImageSize + 10,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 2,
                                    color: Colors.white,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                              child: buildCacheNetworkImage(
                                                  width: boxImageSize + 10,
                                                  height: boxImageSize + 10,
                                                  url: p.shopda['gallery']
                                                      [index])),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('  popular shops',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {},
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
                    Selector<Funcprovider, Future>(
                        selector: (context, pro) => pro.Servicessh(id),
                        builder: (context, value, child) {
                          return FutureBuilder(
                              future: value,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final map = snapshot.data as List;
                                  return GridView.count(
                                    padding: const EdgeInsets.all(12),
                                    primary: false,
                                    childAspectRatio: 4 / 1.6,
                                    shrinkWrap: true,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    crossAxisCount: 2,
                                    children:
                                        List.generate(map.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) => shop(
                                          //       id:  map[index]['id'],
                                          //     )));
                                        },
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 2,
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10)),
                                                    child: buildCacheNetworkImage(
                                                        width: (MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2) *
                                                                (1.6 / 4) -
                                                            12 -
                                                            1,
                                                        height: (MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2) *
                                                                (1.6 / 4) -
                                                            12 -
                                                            1,
                                                        url: map[index]
                                                            ['image'])),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(map[index]['name'],
                                                            style: const TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                            '${map[index]['rate']} Rate',
                                                            style: const TextStyle(
                                                                fontSize: 9,
                                                                color: Color(
                                                                    0xFF37474f)))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    }),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              });
                        }),
                    p.shopda['sub'].isNotEmpty?
                    // SizedBox(
                    //   height: 200,
                    //   child: MealsListView(),
                    // ):Container(),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        elevation: 20,
                        child: Container(
                          color: Colors.redAccent,
                            padding:const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                    child: ListView.builder(
                                        itemCount: p.shopda['sub']['details'].length,
                                        itemBuilder: (context, index) {

                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${p.shopda['sub'][index]['details']} ",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  letterSpacing: 0.2,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  ),
                                ),
                                Text(
                                  p.shopda['sub']['start_date'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(

                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                Text(
                                  p.shopda['sub']['expiry_date'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(

                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                )

                              ],
                            ),
                      ),
                    ))
                        :Container(),


                    Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Review'),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text('View All'),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                _reusableWidget.createRatingBar(
                                    rating: 2, size: 12),
                                const Text('??????????????????',
                                    style: TextStyle(
                                        fontSize: 11, color: SOFT_GREY))
                              ],
                            ),
                            p.shopda['reviews'].isNotEmpty?
                            Column(
                                children:List.generate(p.shopda['reviews'].length <2?1:2, (index)
                                {
                              return Column(
                                children: [
                                  Divider(
                                    height: 32,
                                    color: Colors.grey[400],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          p.shopda['reviews']
                                          [index]['user']
                                          ,
                                          style: const TextStyle(
                                              fontSize: 13, color: SOFT_GREY)),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${p.shopda['reviews']
                                          [index]['user']}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(p.shopda['reviews'][index]['review']),
                                          _reusableWidget.createRatingBar(
                                              rating:double.parse(p.shopda['reviews'][index]['rate']), size: 12),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            })):
                                Container(),
                          ],
                        )),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  // Widget _createAppBar() {
  //   return SizedBox(
  //     height: 80,
  //     child: AnimatedBuilder(
  //       animation: _topColorAnimationController,
  //       builder: (context, child) => AppBar(
  //         automaticallyImplyLeading: false,
  //         backgroundColor: _appBarColor.value,
  //         systemOverlayStyle: _appBarSystemOverlayStyle,
  //         elevation: 0,
  //         title: TextButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                 (Set<MaterialState> states) => topSearchColor,
  //               ),
  //               overlayColor: MaterialStateProperty.all(Colors.transparent),
  //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(3.0),
  //               )),
  //             ),
  //             onPressed: () {
  //               Fluttertoast.showToast(
  //                   msg: 'Click search', toastLength: Toast.LENGTH_SHORT);
  //             },
  //             child: Row(
  //               children: [
  //                 const SizedBox(width: 8),
  //                 Icon(
  //                   Icons.search,
  //                   color: Colors.grey[500],
  //                   size: 18,
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Text(
  //                   'Search product',
  //                   style: TextStyle(
  //                       color: Colors.grey[500],
  //                       fontWeight: FontWeight.normal),
  //                 )
  //               ],
  //             )),
  //         actions: [
  //           GestureDetector(
  //               onTap: () {
  //                 Fluttertoast.showToast(
  //                     msg: 'Click message', toastLength: Toast.LENGTH_SHORT);
  //               },
  //               child: Icon(Icons.email, color: topIconColor)),
  //           IconButton(
  //               icon: Icon(Icons.notifications, color:topIconColor),
  //               onPressed: () {
  //                 Fluttertoast.showToast(
  //                     msg: 'Click notification',
  //                     toastLength: Toast.LENGTH_SHORT);
  //               }),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
