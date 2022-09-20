import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../presentation/constant.dart';
import '../model/product_model.dart';
import '../model/review_model.dart';
import '../presentation/style_Button.dart';
import '../res/cache_image_network.dart';
import '../res/reusable_widget.dart';

class details_screen extends StatelessWidget {
   details_screen({Key? key}) : super(key: key);
   final _reusableWidget = ReusableWidget();
   final List<ProductModel> _productData = [
     ProductModel(
       image:
       'https://unctad.org/sites/default/files/inline-images/ccpb_workinggroup_productsafety_800x450.jpg',
     ),
     ProductModel(
       image:
       'https://unctad.org/sites/default/files/inline-images/ccpb_workinggroup_productsafety_800x450.jpg',
     ),
     ProductModel(
       image:
       'https://unctad.org/sites/default/files/inline-images/ccpb_workinggroup_productsafety_800x450.jpg',
     ),
     ProductModel(
       image:
       'https://unctad.org/sites/default/files/inline-images/ccpb_workinggroup_productsafety_800x450.jpg',
     ),
     ProductModel(
       image:
       'https://unctad.org/sites/default/files/inline-images/ccpb_workinggroup_productsafety_800x450.jpg',
     ),
     ProductModel(
       image:
       'https://unctad.org/sites/default/files/inline-images/ccpb_workinggroup_productsafety_800x450.jpg',
     ),
   ];
   Color _color1 = Color(0xFF515151);
   late List<int> boxHeightList = [];
   int itemCount = 20;

   final rnd = Random();

   @override
  Widget build(BuildContext context) {
     final double boxImageSize = (MediaQuery.of(context).size.width / 3);
     final int boxWidth = (((MediaQuery.of(context).size.width) - 24) / 2 - 12).round();


     return Scaffold(
          backgroundColor:Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(
              top: 31.4,left: 2,right: 2,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white70,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image:NetworkImage('https://kirajmutanaqil.com/wp-content/uploads/2021/02/%D9%85%D9%8A%D9%83%D8%A7%D9%86%D9%8A%D9%83%D9%8A-%D9%85%D8%AA%D9%86%D9%82%D9%84.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 8),
                          child: InkWell(
                            child: const Icon(Icons.arrow_back),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0.0,
                      ),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              elevation: 2,
                              child: SizedBox(
                                width: double.infinity,
                                height: 150,

                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Preferred Merchants',
                                          ),
                                          GestureDetector(
                                              onTap: () {},
                                              child: const Icon(Icons.info_outline,
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
                                                  'https://s3-eu-west-1.amazonaws.com/forasna/uploads/logos/thumb_clogo_2020-07-14-14-44-18_WknXRlY4iOvdElwd4Ur4oAXX.jpg')),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 16),
                                              child: const Text('Steam Boat Lovers - Lefferts Avenue',style: const TextStyle(fontWeight: FontWeight.bold),
                                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 16),
                                              child: const Text(
                                                'Hot, Fresh, Steam',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.star, color: Colors.orange, size: 15),
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

                            ),const SizedBox(height: 5,),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Descripes',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Masasaa losdasld alsdlasdao asldlasldo asdlalsdoa lalsdoa sdasdasd asdasda asdasd asda .',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  WaterfallFlow.builder(
                                    primary: false,
                                    //cacheExtent: 0.0,
                                    //reverse: true,
                                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      // collectGarbage: (List<int> garbages) {
                                      //   print('collect garbage : $garbages');
                                      // },
                                      // viewportBuilder: (int firstIndex, int lastIndex) {
                                      //   print('viewport : [$firstIndex,$lastIndex]');
                                      // },
                                    ),
                                    itemBuilder: (BuildContext c, int index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 2,
                                        color: Colors.white,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            Fluttertoast.showToast(msg: 'Click Images');
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10)),
                                                  child: buildCacheNetworkImage(width: boxWidth.toDouble(), height: boxHeightList[index].toDouble(), url: 'https://picsum.photos/'+boxWidth.toString()+'/'+boxHeightList[index].toString()+'/')),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Title '+(index+1).toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: _color1
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: itemCount,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Gallery',
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
                                      Container(
                                          margin: const EdgeInsets.only(top: 16),
                                          height: boxImageSize * 1.15,
                                          child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _productData.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return _buildLastSearchCard(index, boxImageSize);
                                            },
                                          )),
                                    ],
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, bottom: 20),
                                          child: Row(
                                            children: const <Widget>[
                                               Text(
                                                'Service coast : ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                '& 20.25',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blue),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                                          child: CustomButton(title: 'Get Service', onPressed: () {  },color:const Color(0xFFD1F3FF) ,),
                                        ),
                                        _createProductReview()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }










   Widget _createProductReview() {
     return Container(
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
                 _reusableWidget.createRatingBar(rating: 2, size: 12),
                 const Text('??????????????????',
                     style: TextStyle(fontSize: 11, color: SOFT_GREY))
               ],
             ),
             Column(
                 children: List.generate(4, (index) {
                   return Column(
                     children: [
                       Divider(
                         height: 32,
                         color: Colors.grey[400],
                       ),
                       Container(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(reviewData[index].date,
                                   style:
                                   const TextStyle(fontSize: 13, color: SOFT_GREY)),
                               const SizedBox(height: 4),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(reviewData[index].name,
                                       style: const TextStyle(
                                           fontSize: 14, fontWeight: FontWeight.bold)),
                                   _reusableWidget.createRatingBar(
                                       rating: reviewData[index].rating, size: 12),
                                 ],
                               ),
                               const SizedBox(height: 4),
                               Text(reviewData[index].review)
                             ],
                           ))
                     ],
                   );
                 })),
           ],
         ));
   }
   Widget _buildLastSearchCard(index, boxImageSize) {
     return Container(
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
                   borderRadius: const BorderRadius.only(
                       topLeft: Radius.circular(10),
                       topRight: Radius.circular(10)),
                   child: buildCacheNetworkImage(
                       width: boxImageSize + 10,
                       height: boxImageSize + 10,
                       url: _productData[index].image)),
               // Container(
               //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
               //   child: Column(
               //     mainAxisAlignment: MainAxisAlignment.start,
               //     crossAxisAlignment: CrossAxisAlignment.start,
               //     children: [
               //       Container(
               //         margin: const EdgeInsets.only(top:5),
               //       ),
               //       Container(
               //         margin: const EdgeInsets.only(top:5),
               //       )
               //     ],
               //   ),
               // ),
             ],
           ),
         ),
       ),
     );
   }



}