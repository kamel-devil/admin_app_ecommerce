import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../main.dart';
import '../../provider/provider.dart';
import 'avatar_image.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final ItemScrollController _scrollController = ItemScrollController();
  String time = 'day';

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF212232),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF212232)),
            ),
            child: const AvatarImage(
              'http://www.goodmorningimagesdownload.com/wp-content/uploads/2020/11/Facebook-Profile-Images-40.jpg',
              isSVG: false,
              width: 30,
              height: 30,
            ),
            onPressed: () {},
          )
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AvatarImage(
                    'http://www.goodmorningimagesdownload.com/wp-content/uploads/2020/11/Facebook-Profile-Images-40.jpg',
                    isSVG: false,
                    width: 30,
                    height: 30,
                  ),
                  const Text(
                    'Kamel Shaltout',
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.amberAccent,
                      ))
                ],
              ),
            ),
            FutureBuilder(
              future: p.card(),
              builder: (context, snapshot) {
                if(snapshot.hasData&&p.dataCard.isNotEmpty){
                  return Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(15),
                          width: 380,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children:  [
                                  const AvatarImage(
                                    'https://www.pngitem.com/pimgs/m/3-31745_shopping-cart-icon-blue-hd-png-download.png',
                                    isSVG: false,
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                      child: Text(
                                       p.dataCard[0]['title']??'Shops',
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                            fontSize: 24, fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text(
                                        '${p.dataCard[0]['value']??'9999'}',
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontSize: 24, fontWeight: FontWeight.w500,color:HexColor((p.dataCard[0]['color'])) ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 3, right: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(40),
                                        borderRadius: BorderRadius.circular(30)),
                                    child: Row(
                                      children:  [
                                        p.dataCard[0]['change']==true?
                                         Icon(Icons.trending_up,
                                          color: HexColor((p.dataCard[0]['changeColor'])),size: 40,): Icon(Icons.trending_down,
                                          color:HexColor((p.dataCard[0]['changeColor'])),size: 40,),

                                         Text(
                                           p.dataCard[0]['percent']?? '90%',
                                          style: TextStyle(
                                              fontSize: 24, color: HexColor((p.dataCard[0]['changeColor']))),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(15),
                                width: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white.withOpacity(0.4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(1, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children:  [
                                        const AvatarImage(
                                          'https://www.pngitem.com/pimgs/m/3-31745_shopping-cart-icon-blue-hd-png-download.png',
                                          isSVG: false,
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Text(
                                              p.dataCard[1]['title']??'Shops',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Text(
                                              '${p.dataCard[1]['value']??'9999'}',
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontSize: 12, fontWeight: FontWeight.w500,color: HexColor((p.dataCard[1]['color']))),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 3, right: 3),
                                          decoration: BoxDecoration(
                                              color: Colors.white.withAlpha(40),
                                              borderRadius: BorderRadius.circular(30)),
                                          child: Row(
                                            children:  [
                p.dataCard[1]['change']==true?
                Icon(Icons.trending_up,
                color: HexColor((p.dataCard[1]['changeColor'])),): Icon(Icons.trending_down,
                color:HexColor((p.dataCard[1]['changeColor'])),),

                Text(
                p.dataCard[1]['percent']?? '90%',
                style: TextStyle(
                fontSize: 10, color: HexColor((p.dataCard[1]['changeColor']))),
                ),
                ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                            Container(
                                padding: const EdgeInsets.all(15),
                                width: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white.withOpacity(0.4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(1, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children:  [
                                        const AvatarImage(
                                          'https://www.pngitem.com/pimgs/m/3-31745_shopping-cart-icon-blue-hd-png-download.png',
                                          isSVG: false,
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Text(
                                              p.dataCard[2]['title']??'Shops',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Text(
                                              '${p.dataCard[2]['value']??'9999'}',
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontSize: 12, fontWeight: FontWeight.w500,color: HexColor((p.dataCard[2]['color']))),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 3, right: 3),
                                          decoration: BoxDecoration(
                                              color: Colors.white.withAlpha(40),
                                              borderRadius: BorderRadius.circular(30)),
                                          child: Row(
                                            children:  [
                                              p.dataCard[2]['change']==true?
                                              Icon(Icons.trending_up,
                                                color: HexColor((p.dataCard[2]['changeColor'])),): Icon(Icons.trending_down,
                                                color:HexColor((p.dataCard[2]['changeColor'])),),

                                              Text(
                                                p.dataCard[2]['percent']?? '90%',
                                                style: TextStyle(
                                                    fontSize: 10, color: HexColor((p.dataCard[2]['changeColor']))),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  );

                }else{
                  return const CircularProgressIndicator();
                }
              }
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(colors: [
                        Colors.yellow.shade600,
                        Colors.orange,
                        Colors.red
                      ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xFF2B3245)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    time = 'day';
                                  });
                                },
                                highlightColor: Colors.red.withOpacity(0.4),
                                splashColor:Colors.red,
                                child: const Text('Day',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    time = 'week';
                                  });
                                },
                                child: const Text('week',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    time = 'month';
                                  });
                                },
                                child: const Text('month',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: p.ranking(time),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && p.dataRanking.isNotEmpty) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                WinnerContainer(
                                  color: p.dataRanking[1]['is_me'] == true
                                      ? Colors.amber
                                      : const Color(0xFF2B3245),
                                  winnerPosition:
                                      p.dataRanking[1]['rank'].toString(),
                                  height: 120.0,
                                  winnerName: p.dataRanking[1]['name'],
                                  image: p.dataRanking[1]['image'],
                                  countRank:
                                      p.dataRanking[1]['points'].toString(),
                                ),
                                WinnerContainer(
                                  isFirst: true,
                                  color: p.dataRanking[0]['is_me'] == true
                                      ? Colors.amber
                                      : const Color(0xFF2B3245),
                                  winnerPosition:
                                      p.dataRanking[0]['rank'].toString(),
                                  height: 140.0,
                                  winnerName: p.dataRanking[0]['name'],
                                  image: p.dataRanking[0]['image'],
                                  countRank:
                                      p.dataRanking[0]['points'].toString(),
                                ),
                                WinnerContainer(
                                  color: p.dataRanking[2]['is_me'] == true
                                      ? Colors.amber
                                      : const Color(0xFF2B3245),
                                  winnerPosition:
                                      p.dataRanking[2]['rank'].toString(),
                                  height: 100.0,
                                  winnerName: p.dataRanking[2]['name'],
                                  image: p.dataRanking[2]['image'],
                                  countRank:
                                      p.dataRanking[2]['points'].toString(),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  const SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      gradient: LinearGradient(colors: [
                        Colors.yellow.shade600,
                        Colors.orange,
                        Colors.red
                      ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          color: Color(0xFF212232),
                        ),
                        child: ScrollablePositionedList.builder(
                          itemScrollController: _scrollController,
                          itemCount: p.dataRanking.length,
                          itemBuilder: (BuildContext context, int index) {
                            _scrollController.scrollTo(
                                index: 7, duration: const Duration(seconds: 1));
                            return itemRang(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemRang(index) {
    var p = Provider.of<Funcprovider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: p.dataRanking[index]['is_me'] == true
                ? Colors.amber
                : const Color(0xFF2B3245)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text(
                  '${p.dataRanking[index]['rank'] ?? '1'}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    p.dataRanking[index]['image'] ??
                        'https://cdn-icons-png.flaticon.com/128/4128/4128176.png',
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.cover,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.dataRanking[index]['name'] ?? 'Name',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '@${p.dataRanking[index]['name'] ?? 'Name'}',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${p.dataRanking[index]['points'] ?? '1234'}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WinnerContainer extends StatelessWidget {
  final bool? isFirst;
  final Color? color;
  final String? winnerPosition;
  final String? image;
  final String? winnerName;
  final String? rank;
  final String? countRank;
  final double? height;

  const WinnerContainer(
      {Key? key,
      this.isFirst = false,
      this.color,
      this.winnerPosition,
      this.winnerName,
      this.rank,
      this.height,
      this.image,
      this.countRank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Center(
            child: Container(
              height: height ?? 140.0,
              width: 100.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.yellow.shade600,
                    Colors.orange,
                    Colors.red
                  ]),
                  border: Border.all(color: Colors.amber),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    color: color ?? const Color(0xFF2B3245),
                  ),
                ),
              ),
            ),
          ),
        ),
        Stack(
          children: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                  child: isFirst == true
                      ? Image.asset('assets/images/king.png',
                          height: 70.0, width: 70.0)
                      : Container()),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 15, right: 15),
                child: Container(
                  height: 80.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red),
                      image: DecorationImage(
                          image: NetworkImage(image ??
                              'https://cdn.iconscout.com/icon/free/png-128/avatar-370-456322.png'),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 115.0, left: 15, right: 15),
              child: Container(
                height: 20.0,
                width: 20.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: Center(
                  child: Text(
                    winnerPosition ?? '1',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150.0, left: 23),
          child: Column(
            children: [
              Text(
                winnerName ?? 'Kamel',
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                countRank ?? '99999',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
