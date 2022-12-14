import 'package:geolocator/geolocator.dart';
import 'package:myuber_rider_app/Assistants/requestAssistant.dart';
import 'package:myuber_rider_app/DataHandler/appData.dart';
import 'package:myuber_rider_app/Models/address.dart';
import 'package:myuber_rider_app/configMaps.dart';
import 'package:provider/provider.dart';

class AssistantMethods
{
  static Future<String>searchCoordinateAddress(Position position, context) async
  {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);
    if(response != "failed")
    {
      //placeAddress = response["results"][0]["formatted_address"];
      st1 = placeAddress = response["results"][0]["address_components"][0]["long_name"];
      st2 = placeAddress = response["results"][0]["address_components"][4]["long_name"];
      st3 = placeAddress = response["results"][0]["address_components"][5]["long_name"];
      st4 = placeAddress = response["results"][0]["address_components"][6]["long_name"];

      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false).updatePicUpLocationAddress(userPickUpAddress);

    }
    return placeAddress;
  }
}