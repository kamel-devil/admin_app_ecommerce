
import 'package:e_commerce/res/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/constant.dart';

class BarChartsListPage extends StatefulWidget {
  @override
  _BarChartsListPageState createState() => _BarChartsListPageState();
}

class _BarChartsListPageState extends State<BarChartsListPage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _globalWidget.globalAppBar(),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          children: [
             Text('Bar Charts List'.tr, style: const TextStyle(
                fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
            )),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  const Flexible(
                      flex:5,
                      child: Text('Data visualization using bar charts', style: TextStyle(
                          fontSize: 15, color: BLACK77,letterSpacing: 0.5
                      ))
                  ),
                  Flexible(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.center,
                          child: const Icon(Icons.bar_chart, size: 50, color: SOFT_BLUE))
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 48),
              child: const Text('List', style: TextStyle(
                  fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
              )),
            ),
            const SizedBox(height: 18),
          ],
        )
    );
  }
}
