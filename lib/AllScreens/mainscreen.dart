
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myuber_rider_app/AllScreens/searchScreen.dart';
import 'package:myuber_rider_app/AllWidgets/Divider.dart';
import 'package:myuber_rider_app/Assistants/assistantMethods.dart';
import 'package:myuber_rider_app/Assistants/assistantMethods.dart';
import 'package:myuber_rider_app/DataHandler/appData.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen" ;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    
    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address ::" + address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Rider's Main Screen ",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0, fontFamily: "Brand-Bold",
        ),),
      ),
      drawer: Container(
        color: Colors.white70,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
                      SizedBox(width: 16.0,),
                      Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile Name", style: TextStyle(color: Colors.blueGrey, fontSize: 16.0, fontFamily: "Brand-Bold"),),
                        SizedBox(height: 6.0,),
                        Text("Visit Profile", style: TextStyle(color: Colors.blueGrey, fontFamily: "Brand-Bold"),)
                      ],),
                    ],
                  ),
                ),
              ),
              DividerWidget(),
              SizedBox(height: 12.0,),
              //Drawer body controllers
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History", style: TextStyle(fontFamily: "Brand-Bold",color: Colors.blueGrey, fontSize: 16.0),),
              ),
              SizedBox(height: 12.0,),
              //Drawer body controllers
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Visit Profile", style: TextStyle(fontFamily: "Brand-Bold",color: Colors.blueGrey, fontSize: 16.0),),
              ),
              SizedBox(height: 12.0,),
              //Drawer body controllers
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About", style: TextStyle(fontFamily: "Brand-Bold",color: Colors.blueGrey, fontSize: 16.0),),
              ),
              //SizedBox(height: 12.0,),
              //Drawer body controllers
              //ListTile(
                //leading: Icon(Icons.history),
                //title: Text("History", style: TextStyle(fontFamily: "Brand-Bold",color: Colors.blueGrey, fontSize: 16.0),),),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 265.0;
              });
              locatePosition();

            },

          ),
          //hamburger Button for Drawer
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: ()
              {
                scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius:6.0,
                  spreadRadius: 0.5, offset: Offset(0.7,0.7))]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu, color: Colors.blueGrey,), radius: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 2.0,
            right: 2.0,
            bottom: 2.0,
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0),
                    bottomLeft: Radius.elliptical(18, 18),bottomRight: Radius.elliptical(18, 18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0,),
                    Text("Hi there..", style: TextStyle(fontSize: 18.0),),
                    SizedBox(height: 5.0,),
                    Text("Where to", style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7,0.7),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.blueGrey,),
                            SizedBox(width: 10.0,),
                            Text("Search Drop off Location")
                          ],
                        ),

                      ),
                    ),
                    SizedBox(height: 20.0,),
                    DividerWidget(),

                    SizedBox(height: 26.0,),
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.blueGrey,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add home", style: TextStyle(fontFamily: "Brand-Bold"),),
                            SizedBox(height: 4.0,),
                            Text("Your Living home address",style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    DividerWidget(),
                    SizedBox(height: 16.0,),

                    Row(
                      children: [
                        Icon(Icons.work, color: Colors.blueGrey,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Provider.of<AppData>(context).pickUpLocation != null
                                  ? Provider.of<AppData>(context).pickUpLocation.placeName
                                  : "Add Home" , style: TextStyle(fontFamily: "Brand-Bold", color: Colors.blueGrey),
                            ),
                            SizedBox(height: 6.0,),
                            Text("Your Office address",style: TextStyle(color: Colors.blueGrey, fontSize: 12.0, fontFamily: "Brand-Bold"),)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
