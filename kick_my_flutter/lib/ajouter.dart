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
import 'http/model.dart';
import 'i18n/intl_localization.dart';

class AjouterPage extends StatefulWidget {
  AjouterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AjouterPage createState() => _AjouterPage();
}



class _AjouterPage extends State<AjouterPage> {

  DateTime selectedDate = DateTime.now();

  Tache tacheCourante =  Tache();

  final NomController = TextEditingController();

  bool _saving = false;

  void _tacheCourante() {
    tacheCourante.name = NomController.text;
    tacheCourante.deadline = selectedDate.toString();
    tacheCourante.start = DateTime.now().toString();
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

  void termine() {
    postTacheFB(tacheCourante);

    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccueilPage(title: Locs.of(context).trans('ACCUEIL')))
    );
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
                      _tacheCourante();
                      postTacheFB(tacheCourante);
                      Navigator.push(
                      context,
                          MaterialPageRoute(builder: (context) => AccueilPage(title: Locs.of(context).trans('ACCUEIL')))
                      );
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