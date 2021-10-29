import 'page_list.dart';
import 'package:flutter/material.dart';

class ListBlock extends StatelessWidget {
  const ListBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 10,
          style: BorderStyle.none,
        ),
      ),
      child: PageView(
        children: <Widget>[
          PageList(
            stringLists: List.generate(
                31,
                (index) =>
                    ["${index + 1}", "OTOGAR-KARAMAN", "${69 - index}dk"]),
          ),
          PageList(
            stringLists: const [
              ["Eren Çakar", "Oğul"],
            ],
          ),
        ],
      ),
    );
  }
}
