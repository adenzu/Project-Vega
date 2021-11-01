import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    
     return Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              searchBar(),
              ],
            ),
            ),
        ),
        );
        
        
  }
  Widget searchBar(){
    return TextFormField(
          decoration: InputDecoration(labelText: "Search Bar", hintText: "asdfg"),
        );
  }
}