import 'package:flutter/cupertino.dart';
import 'package:myuber_rider_app/Models/address.dart';

class AppData extends ChangeNotifier
{
  Address pickUpLocation;

  void updatePicUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}