import 'package:flutter/material.dart';

import 'page_list.dart';

class ListBlock extends StatelessWidget {
  const ListBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 10,
          style: BorderStyle.none,
        ),
      ),
      // aşağıdaki değerler tamamiyle yer tutması içindir ve görünüm amaçlıdır
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
              ["Boş Boş", "Boş"],
            ],
          ),
        ],
      ),
    );
  }
}
