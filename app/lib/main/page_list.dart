import 'page_row.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageList extends StatelessWidget {
  List<Widget?>? leadings;
  final List<List<String>> stringLists;

  PageList({
    this.leadings,
    this.stringLists = const [],
  });

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
