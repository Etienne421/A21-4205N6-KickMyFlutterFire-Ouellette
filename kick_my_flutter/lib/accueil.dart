import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kick_my_flutter/ajouter.dart';
import 'package:kick_my_flutter/connection.dart';
import 'package:kick_my_flutter/consultation.dart';
import 'package:kick_my_flutter/tiroir_nav.dart';
import 'package:kick_my_flutter/util.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'http/transfer.dart';
import 'i18n/intl_localization.dart';

class AccueilPage extends StatefulWidget {
  AccueilPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AccueilPage createState() => _AccueilPage();
}


class _AccueilPage extends State<AccueilPage> {


  List<HomeItemResponse> liste =[];

  bool _saving = false;


  void getListAccueil() async{
    try {
      loadingState();
      this.liste = await listAccueil().timeout(const Duration(seconds: 30));

      loadingState();
      setState(() {});
    } on TimeoutException {
      loadingState();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans('TIME_OUT'))
          )
      );
    } catch (e) {
      print(e);
      loadingState();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans('ERROR_NETWORK'))
          )
      );
    }
  }

  void loadingState() {
    _saving = !_saving;
    setState(() {});
  }

  @override
  void initState(){
    getListAccueil();
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


  Widget maListe2(List<HomeItemResponse> listePara) {
    return ListView.separated(
        itemCount: liste.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black54,),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultationPage(title: 'Consultation', idele: listePara[index].id))
              );
            },
            child:

               //Container(height: 20, color: Colors.amber,),
            Row(
              children: [
                Container(
                  width: 50,
                  child: Image.network(
                      'http://10.0.2.2:8080' + "/file/task/" + listePara[index].id.toString() + "?width=50",
                      errorBuilder:
                          (BuildContext context, Object exception, StackTrace? stackTrace) {
                            //placeholder: 'assets/image/red.jpg'
                        //return Image.asset('assets/image/red.jpg');
                            return Container(width: 50,height: 50, color: Colors.black26,);
                      },
                    loadingBuilder: (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }else {
                        return Container(color: Colors.red, width: 50, height: 50,);
                      }
                    },
                  //   loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  //     if (loadingProgress == null) return child;
                  //     return Center(
                  //       child: CircularProgressIndicator(
                  //         value: loadingProgress.expectedTotalBytes != null ?
                  //         loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                  //             : null,
                  //       ),
                  //     );
                  //   },
                  // ),
                    // loadingBuilder: (context, child, loadingProgress) {
                      // if (loadingProgress == null) return child;
                      //
                      // return Container(width:50, child: Text('Loading...'),color: Colors.red,);
                      // },
                  ),
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
                                child: Center(child: Text(format(listePara[index].deadline))),),
                            )
                      ],),
                      Row(children: [
                        Expanded(
                            flex:1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(child: Text(listePara[index].percentageTimeSpent.toString()))
                            )
                        ),
                        Expanded(
                            flex:1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(child: Text(listePara[index].percentageDone.toString() + '%'))
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