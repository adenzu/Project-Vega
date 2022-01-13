import 'package:app/database/functions.dart';
import 'package:app/shuttle_creation/shuttle_info_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class ShuttleCreationScreen2 extends StatefulWidget {
  final String _plate;
  final String _shuttleBrand;
  final String _shuttleModel;
  final int _shuttleYear;

  const ShuttleCreationScreen2(
      {Key? key,
      required String plate,
        required String shuttleBrand,
        required String shuttleModel,
        required int shuttleYear,})
      : _plate = plate,
        _shuttleBrand = shuttleBrand,
        _shuttleModel = shuttleModel,
        _shuttleYear = shuttleYear,
        super(key: key);

  @override
  _ShuttleCreationScreen2State createState() => _ShuttleCreationScreen2State();
}

class _ShuttleCreationScreen2State extends State<ShuttleCreationScreen2> {


  final _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance.reference();
  String? _driverName;
  String? _shuttleCompany;
  int? _seatNumber;
  String? _shuttleEName;
  int? _shuttleLicense;
  int? _driverID;



  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFD8D8D8),
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
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
                            CupertinoIcons.back,
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
                            CupertinoIcons.checkmark_alt,
                            color: Colors.blue,
                            size: _size.width * 0.15,
                          ),
                          onPressed: () {
                            final isValid = _formKey.currentState!.validate();
                            FocusScope.of(context).unfocus();
                            if (isValid) {
                              final ShuttleInformation _si = ShuttleInformation(widget._plate, widget._shuttleBrand, widget._shuttleModel, widget._shuttleYear, _shuttleCompany, _driverID, _shuttleLicense, _seatNumber);
                              //createShuttle2(_si);
                              _formKey.currentState!.save();
                              // integerlara printlerken 0ları yazmiyor
                              String message = "Plaka: " + widget._plate +"\n";
                              message += "Marka: " + widget._shuttleBrand+"\n";
                              message += "Model: " + widget._shuttleModel+"\n";
                              message += "Yıl: " + widget._shuttleYear.toString()+"\n";
                              message += "Şirket: $_shuttleCompany \n";
                              message += "Koltuk Sayısı: " + _seatNumber.toString()+"\n";
                              message += "Sürücü T.C: " + _driverID.toString()+"\n";
                              message += "Ruhsat No: " + _shuttleLicense.toString();

                              final snackBar = SnackBar(
                                content: Text(
                                    message,
                                    style: const TextStyle(fontSize: 20)
                                ),
                                backgroundColor: Colors.green,

                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildCompany(),
              const SizedBox(height: 25.0),
              buildSeatNumber(),
              const SizedBox(height: 25.0),
              buildDriverID(),
              const SizedBox(height: 25.0),
              buildShuttleLicense(),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildDriverName() => TextFormField(
  //       decoration: const InputDecoration(
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
  //         ),
  //         labelText: "Sürücü İsmi",
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.teal, width: 2.0),
  //         ),
  //         errorBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.red),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.red),
  //         ),
  //         errorStyle: TextStyle(color: Colors.red),
  //         hintText: "Örnek:Ali Ali",
  //         hintStyle: TextStyle(color: Colors.black12),
  //         labelStyle: TextStyle(color: Colors.black87),
  //       ),
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return "Bu alan boş kalamaz.";
  //         } else {
  //           return null;
  //         }
  //       },
  //       onSaved: (value) => setState(() => _driverName = value),
  //     );

  Widget buildCompany() => TextFormField(
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
          ),
          labelText: "Kayıtlı Olunan Şirket",
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
          hintText: "Örnek:Çakmak Turizm",
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
        onSaved: (value) => setState(() => _shuttleCompany = value),
      );

  Widget buildShuttleLicense() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
          ),
          labelText: "Ruhsat Seri Numarası",
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
          hintText: "Örnek:000000",
          hintStyle: TextStyle(color: Colors.black12),
          labelStyle: TextStyle(color: Colors.black87),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Bu alan boş kalamaz.";
          }
          else if(value.length != 6){
            return "Ruhsat numarası 6 haneli olmalıdır.";
          }
          else {
            return null;
          }
        },
        onSaved: (value) => setState(() => _shuttleLicense = int.parse(value!)),
      );

  Widget buildDriverID() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
          ),
          labelText: "Sürücü T.C Kimlik Numarası",
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
          hintText: "Örnek:00000000000",
          hintStyle: TextStyle(color: Colors.black12),
          labelStyle: TextStyle(color: Colors.black87),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Bu alan boş kalamaz.";
          } else if(value.length != 11){
            return "T.C kimlik numarası 11 haneli olmalıdır.";
          }
          else {
            return null;
          }
        },
        onSaved: (value) => setState(() => _driverID = int.parse(value!)),
      );

  Widget buildSeatNumber() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
          ),
          labelText: "Yolcu Koltuk Sayısı",
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
          hintText: "Örnek:18",
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
        onSaved: (value) => setState(() => _seatNumber = int.parse(value!)),
      );

  // Widget buildSEName() => TextFormField(
  //       decoration: const InputDecoration(
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
  //         ),
  //         labelText: "Servis Görevlisi İsmi(Yoksa Sürücü İsmi)",
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.teal, width: 2.0),
  //         ),
  //         errorBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.red),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.red),
  //         ),
  //         errorStyle: TextStyle(color: Colors.red),
  //         hintText: "Örnek:Hatice Hatice",
  //         hintStyle: TextStyle(color: Colors.black12),
  //         labelStyle: TextStyle(color: Colors.black87),
  //       ),
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return "Bu alan boş kalamaz.";
  //         } else {
  //           return null;
  //         }
  //       },
  //       onSaved: (value) => setState(() => _shuttleEName = value),
  //     );
}
