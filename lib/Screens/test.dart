import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'UserModel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text("DropdownSearch Demo")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(4),
            children: <Widget>[


              ///************************[Favorites examples]**********************************///
              const Padding(padding: EdgeInsets.all(8)),
              const Text("[Favorites examples]"),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<UserModel>(
                      onChanged: (value){
                        print(value!.id);
                      },
                      asyncItems: (filter) => getData(filter),
                      compareFn: (i, s) => i.isEqual(s),
                      popupProps: PopupPropsMultiSelection.modalBottomSheet(
                        isFilterOnline: true,
                        showSelectedItems: true,
                        showSearchBox: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        favoriteItemProps: FavoriteItemProps(
                          showFavoriteItems: true,
                          favoriteItems: (us) {
                            return us
                                .where((e) => e.name.contains("Mrs"))
                                .toList();
                          },
                        ),
                      ),

                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<UserModel>.multiSelection(
                      onChanged: (value){
                        value.forEach((element) { print(element.id);});
                      },
                      asyncItems: (filter) => getData(filter),
                      compareFn: (i, s) => i.isEqual(s),
                      popupProps: PopupPropsMultiSelection.modalBottomSheet(
                        showSearchBox: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        favoriteItemProps: FavoriteItemProps(
                          showFavoriteItems: true,
                          favoriteItems: (us) {
                            return us
                                .where((e) => e.name.contains("n"))
                                .toList();
                          },
                          favoriteItemBuilder: (context, item, isSelected) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]),
                              child: Row(
                                children: [
                                  Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.indigo),
                                  ),
                                  const Padding(padding: EdgeInsets.only(left: 8)),
                                  isSelected
                                      ? const Icon(Icons.check_box_outlined)
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context,
      UserModel? item,
      bool isSelected,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Colors.deepOrange),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        trailing: Text(item?.id ?? ''),

        title: Text(item?.name ?? ''),
        leading:  CircleAvatar(
          // this does not work - throws 404 error
          backgroundImage: NetworkImage(item?.avatar ?? ''),
        ),
      ),
    );
  }

  Future<List<UserModel>> getData(filter) async {
    var response = await Dio().get(
      "https://ibtikarsoft.net/finder/api/admin/owners.php?token=aruv8kzsmyo7",
      queryParameters: {"filter": filter},
    );

    final data = jsonDecode(response.data);
    print(data.runtimeType);
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}



