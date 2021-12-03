import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/ajouter.dart';
import 'package:kick_my_flutter/connection.dart';
import 'package:kick_my_flutter/consultation.dart';
import 'package:kick_my_flutter/tiroir_nav.dart';
import 'package:kick_my_flutter/util.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'http/model.dart';
import 'http/transfer.dart';
import 'i18n/intl_localization.dart';

class AccueilPage extends StatefulWidget {
  AccueilPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AccueilPage createState() => _AccueilPage();
}


class _AccueilPage extends State<AccueilPage> {


  List<TacheAccueil> liste =[];

  bool _saving = false;

  void loadingState() {
    _saving = !_saving;
    setState(() {});
  }

  @override
  void initState(){
    accueilTaches();
  }

  accueilTaches() async{
    liste = await getTachesFB();
    setState(() {});
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AjouterPage(title: Locs.of(context).trans('ADD')))
                          );
                        },
                        child: Text(Locs.of(context).trans('ADD'))),
                  ),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54,width: 5),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child:
                      maListe2(liste),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String differenceBetweenStringDate(String start, String deadline) {
    DateTime dateStart = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(start);
    DateTime dateEnd = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(deadline);
    String difference = dateEnd.difference(dateStart).inDays.toString();
    return difference;
  }

  Widget maListe2(List<TacheAccueil> listePara) {
    return ListView.separated(
        itemCount: liste.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black54,),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultationPage(title: 'Consultation', idEle: listePara[index].id))
              );
            },
            child:

               //Container(height: 20, color: Colors.amber,),
            Row(
              children: [
                Container(
                  width: 50,
                  child: (listePara[index].path!='')?Image.network(listePara[index].path, height: 50):Text("X"),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                            flex:1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(child: Text(listePara[index].name))

                            )
                        ),
                        Expanded(
                            flex:1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                //child: Center(child: Text(listePara[index].deadline.toString()))
                                child: Center(child: Text(listePara[index].deadline.split(" ")[0])),),
                            )
                      ],),
                      Row(children: [
                        Expanded(
                            flex:1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(child: Text(
                                    differenceBetweenStringDate(
                                        listePara[index].start.substring(0,listePara[index].start.length - 7),
                                        listePara[index].deadline.substring(0,listePara[index].start.length - 7),
                                    ) + " jours"
                                )
                                )
                            )
                        ),
                        Expanded(
                            flex:1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(child: Text(listePara[index].progression.toString() + '%'))
                            )
                        )
                      ],),

                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  // Widget logo(int id){
  //   Image image = Image.network('http://10.0.2.2:8080' + "/file/task/" + id.toString() + "?width=50");
  //   print(image);
  //   return image;
  // }
}