import 'package:flutter/material.dart';

import 'page_row.dart';

// ignore: must_be_immutable
class PageList extends StatelessWidget {
  List<Widget?>? leadings;
  final List<List<String>> stringLists;

  PageList({
    Key? key,
    this.leadings,
    this.stringLists = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (leadings == null) {
      leadings = List.filled(stringLists.length, null);
    } else if (stringLists.length > leadings!.length) {
      leadings!
          .addAll(List.filled(stringLists.length - leadings!.length, null));
    }
    return ListView.builder(
      itemCount: stringLists.length,
      itemBuilder: (BuildContext context, int index) {
        return PageRow(
          leading: leadings![index],
          stringChildren: stringLists[index],
        );
      },
    );
  }
}
