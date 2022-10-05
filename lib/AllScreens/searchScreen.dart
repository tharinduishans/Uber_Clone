import 'package:flutter/material.dart';
import 'package:myuber_rider_app/DataHandler/appData.dart';
import 'package:myuber_rider_app/configMaps.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
{
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    String placeAddress = Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    pickUpTextEditingController.text = placeAddress ;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(color: Colors.teal ,
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 6.0,
                    spreadRadius: 0.5, offset: Offset(0.7,0.7))]),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 15.0,),
                  Stack(children: [
                    GestureDetector(
                      onTap:()
                      {
                        Navigator.pop(context);
                      },
                        child: Icon(
                            Icons.arrow_back)),
                    Center(child: Text("Set drop Off",
                      style: TextStyle(fontFamily: "Brand-Bold",
                          color: Colors.black, fontSize: 20.0,),),)
                  ],),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [Image.asset("images/pickicon.png", height: 26.0, width: 20.0,),
                      SizedBox(width: 18.0,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            controller: pickUpTextEditingController,
                            decoration: InputDecoration(
                              hintText: "Pick Up location",
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0)
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [Image.asset("images/desticon.png", height: 26.0, width: 20.0,),
                      SizedBox(width: 18.0,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            controller: dropOffTextEditingController,
                            decoration: InputDecoration(
                                hintText: "Drop Down location",
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0)
                            ),
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),

          )
        ],
      ),
    );
  }
  void findPlace(String placeName) async
  {
    if (placeName.length>1)
    {
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890";
    }
  }
}
