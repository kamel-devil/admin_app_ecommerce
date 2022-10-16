import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/language.dart';
import '../classes/language_constants.dart';
import '../main.dart';
import '../presentation/style_Button.dart';
import '../provider/provider.dart';

class screen_location extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(translation(context).homePage),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale locale = await setLocale(language.languageCode);
                  MyApp.setLocale(context, locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    scale: 0.4,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://www.snapsendsolve.com/wp-content/uploads/2021/08/Final-web-01-1.png',
                    )),
              ),
            ),
            Column(
              children: [
                Expanded(child: Container()),
                const Text(
                  '  ACCESS YOUR LOCATION',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  """             Lorem ipsum dolor sit amet,
    consetetur sadipscing elit, sed diam non
     Lorem ipsum dolor sit amet, consetetur""",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomButton(
                    title: 'Use Current Location',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomButton(
                    title: 'Set From Map',
                    onPressed: () {},
                    color: const Color(0xFFD1F3FF),
                  ),
                ),
                const SizedBox(
                  height: 64,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
