import 'package:e_commerce/provider/provider.dart';
import 'package:e_commerce/register/signin2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'classes/language_constants.dart';
import 'flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  // Widget _buildTrendingProductCard(index){
  //   return Consumer<Funcprovider>(builder: (context, value, child) {
  //     return FutureBuilder(
  //         future: value.Servicessh('0'),
  //         builder: (context, snapshot) {
  //           if(snapshot.hasData){
  //             final list=snapshot.data as List;
  //             return GestureDetector(
  //               onTap: () {
  //               },
  //               child: Card(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   elevation: 2,
  //                   color: Colors.white,
  //                   child: Row(
  //                     children: [
  //                       ClipRRect(
  //                           borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: const Radius.circular(10)),
  //                           child: buildCacheNetworkImage(width: (MediaQuery.of(context).size.width/2)*(1.6/4)-12-1, height: (MediaQuery.of(context).size.width/2)*(1.6/4)-12-1, url: list[index]['image'])
  //                       ),
  //                       Expanded(
  //                         child: Container(
  //                           margin: const EdgeInsets.all(10),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(list[index]['name'], style: const TextStyle(
  //                                   fontSize: 11, fontWeight: FontWeight.bold
  //                               )),
  //                               const SizedBox(height: 4),
  //                               Text(list[index]['desc'], style: const TextStyle(
  //                                   fontSize: 9, color: BLACK77
  //                               ))
  //                             ],
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   )
  //               ),
  //             );
  //           }else{
  //             return const CircularProgressIndicator();
  //           }
  //         });
  //   } );}

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Funcprovider>(
      create: (context) => Funcprovider()
        ..getCheckLocation()
        ..datacate('0')
        ..datashop('18')
        ..datashops('0')
        ..datapopshops('0'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        home: const Signin2Page(),
      ),
    );
  }
}
