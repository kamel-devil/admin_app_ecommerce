import 'package:e_commerce/Screens/home_admin.dart';
import 'package:e_commerce/provider/provider.dart';
import 'package:e_commerce/register/signin2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Owner/owner.dart';
import 'Screens/test.dart';
import 'classes/language_constants.dart';
import 'custom_drawer/navigation_home_screen.dart';
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
        ..getToken()
      ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        home:Consumer<Funcprovider>(
          builder: (context, value, child) {
            return FutureBuilder(
              future: value.getLogin(),
              builder: (context, snapshot) {

                if (snapshot.data == true) {
                  value.changeLang(_locale!);
                  return   NavigationHomeScreen();
                } else {
                  return Signin2Page();
                }
              },

            );
          },
        ),      ),
    );
  }
}
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

