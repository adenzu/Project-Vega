import 'package:app/database/functions.dart';
import 'package:app/shuttle_creation/shuttle_creation_screen2.dart';
import 'package:app/shuttle_creation/shuttle_info_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class ShuttleCreationScreen1 extends StatefulWidget {
  const ShuttleCreationScreen1({Key? key}) : super(key: key);

  @override
  _ShuttleCreationScreen1State createState() => _ShuttleCreationScreen1State();
}

class _ShuttleCreationScreen1State extends State<ShuttleCreationScreen1> {
  final _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance.reference();
  String _plate = "";
  String _shuttleBrand = "";
  String _shuttleModel = "";
  int _shuttleYear = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            SizedBox(
              height: _size.height * 0.15,
              width: _size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.clear_thick,
                          color: Colors.black,
                          size: _size.width * 0.15,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Otobüs Oluşturma",
                          style: TextStyle(
                              fontSize: _size.width * 0.06,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.forward,
                          color: Colors.blue,
                          size: _size.width * 0.15,
                        ),
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();
                          FocusScope.of(context).unfocus();
                          if (isValid) {
                            _formKey.currentState!.save();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ShuttleCreationScreen2(
                                        plate: _plate,
                                        shuttleBrand: _shuttleBrand,
                                        shuttleModel: _shuttleModel,
                                        shuttleYear: _shuttleYear,
                                      )),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildPlate(),
            const SizedBox(height: 25.0),
            buildBrand(),
            const SizedBox(height: 25.0),
            buildModel(),
            const SizedBox(height: 25.0),
            buildYear(),
            // const SizedBox(height: 16.0),
            // buildDriverName(),
            // const SizedBox(height: 16.0),
            // buildLicense(),
          ],
        ),
      ),
    );
  }

  Widget buildPlate() => TextFormField(
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
            ),
            labelText: "Plaka",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            errorStyle: TextStyle(color: Colors.red),
            labelStyle: TextStyle(color: Colors.black87),
            hintText: "Örnek:41P4141",
            hintStyle: TextStyle(color: Colors.black12)),
        validator: (value) {
          // database plaka check yapilacak
          String _temp;
          _temp = value!.replaceAll(' ', '');
          _temp = _temp.toUpperCase();

          //
          // _checkPlate() async{
          //   bool checkPlate = await isPlateOnDatabase(_temp);
          // }
          //
          if (_temp.length > 9) {
            return "Plaka Standarlarına uygun plaka girin.";
          }
          else if(isPlateOnDatabase(_temp) == false){
            return "Girilen plaka daha önce kullanılmıştır.";
          }
          else if (!_temp.contains('P')) {
            return "Servis Plakaları P plaka olmak zorundadır.";
          } else if (_temp.length > 3 && _temp.contains(RegExp(r'[A-Z]'), 3)) {
            return "Servis Plakaları P plaka olmak zorundadır.";
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() {
          String _temp;
          _temp = value!.replaceAll(' ', '');
          _temp = _temp.toUpperCase();
          _plate = _temp;
        }),
      );

  Widget buildBrand() => TextFormField(
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
          ),
          labelText: "Otobüs Markası",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(color: Colors.red),
          hintText: "Örnek:Mercedes-Benz",
          hintStyle: TextStyle(color: Colors.black12),
          labelStyle: TextStyle(color: Colors.black87),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Bu alan boş kalamaz.";
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => _shuttleBrand = value!),
      );

  Widget buildModel() => TextFormField(
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
          ),
          labelText: "Otobüs Modeli",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(color: Colors.red),
          hintText: "Örnek:Sprinter",
          hintStyle: TextStyle(color: Colors.black12),
          labelStyle: TextStyle(color: Colors.black87),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Bu alan boş kalamaz.";
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => _shuttleModel = value!),
      );

  Widget buildYear() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
          ),
          labelText: "Otobüs Model Yılı",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(color: Colors.red),
          hintText: "Örnek:2021",
          hintStyle: TextStyle(color: Colors.black12),
          labelStyle: TextStyle(color: Colors.black87),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Bu alan boş kalamaz.";
          } else if (value.length != 4 || int.parse(value) > 2023) {
            return "Geçerli bir yıl girin.";
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => _shuttleYear = int.parse(value!)),
      );
}
