
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
import 'meals_list_data.dart';

class MealsListView extends StatefulWidget {
  const MealsListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: p.subscription(),
        builder: (context, snapshot) {
          if(p.sub.isNotEmpty){
            final list=snapshot.data as List;
            return SizedBox(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                  list.length > 10 ? 10 : list.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return MealsView(
                    mealsListData: list[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            );
          }else{
            return const CircularProgressIndicator();
          }

        }
      ),
    );
  }
}

class MealsView extends StatefulWidget {
  const MealsView(
      {Key? key, required this.mealsListData, this.animationController, this.animation})
      : super(key: key);

  final  Map mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  String sub_Id='';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 170,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: InkWell(
                      onTap: (){
                         widget.mealsListData['id'];
                         setState(() {
                           sub_Id =  widget.mealsListData['id'];
                         });
                         print(sub_Id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.blueGrey
                                    .withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                          gradient: const LinearGradient(
                            colors: [
                              Colors.redAccent,
                              Colors.deepOrangeAccent
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(54.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 16, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.mealsListData['name'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(

                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 0.2,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ListView.builder(
                                    itemCount: widget.mealsListData['details'].length,
                                    itemBuilder: (context, index) {

                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${widget.mealsListData['details'][index]} ",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    widget.mealsListData['duration'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(

                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: 0.2,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
