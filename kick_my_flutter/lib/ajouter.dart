import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kick_my_flutter/connection.dart';
import 'package:kick_my_flutter/http/transfer.dart';
import 'package:kick_my_flutter/tiroir_nav.dart';
import 'package:kick_my_flutter/util.dart';

import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';


import 'accueil.dart';
import 'i18n/intl_localization.dart';

class AjouterPage extends StatefulWidget {
  AjouterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AjouterPage createState() => _AjouterPage();
}



class _AjouterPage extends State<AjouterPage> {

  DateTime selectedDate = DateTime.now();

  AddTaskRequest tacheCourante =  AddTaskRequest();

  final NomController = TextEditingController();

  bool _saving = false;

  void _tacheCourante() {
    tacheCourante.name = NomController.text;
    tacheCourante.deadLine = DateTime.now();
    //tacheCourante.deadLine = selectedDate;
  }

  void loadingState() {
    _saving = !_saving;
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> getAjouter(AddTaskRequest req) async{
    try {
      loadingState();
      tacheCourante.name = NomController.text;
      tacheCourante.deadLine = selectedDate;
      print(tacheCourante.name + ' | ' + tacheCourante.deadLine.toString());
      print(selectedDate);
      await ajouter(req).timeout(const Duration(seconds: 5));
      print(req);
      loadingState();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccueilPage(title: 'Accueil'))
      );
      setState(() {});
    } on TimeoutException catch(e){
      loadingState();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans('TIME_OUT'))
          )
      );
    } on DioError catch(e) {
      print(e);
      loadingState();
      String message = e.response!.data;
      if (message == "IllegalArgumentException") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(Locs.of(context).trans('ERROR_ILLEGAL_ARGUMENT'))
            )
        );
      } else if (message == "Existing") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(Locs.of(context).trans('ERROR_ALREADY_EXIST'))
            )
        );
      } else {
        loadingState();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(Locs.of(context).trans('ERROR_NETWORK'))
            )
        );
      }
    }
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    NomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeTiroir(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LoadingOverlay(
        isLoading: _saving,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: TextField(
                  controller: NomController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    hintText:Locs.of(context).trans('NAME_TASK'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: Center(child: Text(format(selectedDate))),
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(Locs.of(context).trans('SELECT_DATE')),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      getAjouter(tacheCourante);
                    },
                    child: Text(Locs.of(context).trans('ADD')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}