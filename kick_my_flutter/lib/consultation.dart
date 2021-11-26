

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kick_my_flutter/http/transfer.dart';
import 'package:kick_my_flutter/tiroir_nav.dart';
import 'package:kick_my_flutter/util.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:io';

import 'accueil.dart';
import 'i18n/intl_localization.dart';

class ConsultationPage extends StatefulWidget {
  ConsultationPage({Key? key, required this.title, required this.idele}) : super(key: key);

  final String title;
  final int idele;

  @override
  _ConsultationPage createState() => _ConsultationPage();
}



class _ConsultationPage extends State<ConsultationPage> {

  DateTime selectedDate = DateTime.now();

  final NomController = TextEditingController();

  TaskDetailResponse response = new TaskDetailResponse();

  int progressCourant = 0;

  bool _saving = false;

  final picker = ImagePicker();
  var _imageFile = null;


  @override
  void initState(){

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
                margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text(
                      response.name,
                    style: TextStyle(
                      fontSize: 35
                    ),
                  )
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text(
                      format(response.deadLine),
                    style: TextStyle(
                        fontSize: 35
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          progressMinus();

                        },
                        child: Text('-'),
                      ),
                    ),
                  ),
                  Text(
                      //tacheCourante.percentageDone.toString() + '%'
                    progressCourant.toString() + '%'
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          progressPlus();
                        },
                        child: Text('+'),
                      ),
                    ),
                  ),
                ],
              ),
              _imageFile == null ?
              Container(height: 25,) :
              SizedBox(
                child: Image.file(_imageFile),
                height: 100,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: Text(Locs.of(context).trans('ADD_IMAGE')),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                    },
                    child: Text(Locs.of(context).trans('FINISH')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void progressPlus() {
    if(progressCourant < 100) {
      progressCourant = progressCourant + 20;
    }
    setState(() {});
  }

  void progressMinus() {
    if(progressCourant > 0) {
      progressCourant = progressCourant - 20;
    }
    setState(() {});
  }
}

