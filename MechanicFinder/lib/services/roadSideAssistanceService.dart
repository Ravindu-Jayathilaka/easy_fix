import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic_finder/models/mechanicRoadSideAssistance.dart';


class RoadSideAssistanceService {
  final CollectionReference assistanceCollection = FirebaseFirestore.instance.collection("roadSideAssistance");

  List<MechanicRoadSideAssistance> _quotationFromSnapshot(QuerySnapshot snapshots){
    List<MechanicRoadSideAssistance> quotations = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      quotations.add(
          MechanicRoadSideAssistance(
            snapshots.docs[i].id,
            snapshots.docs[i]["status"],
            snapshots.docs[i]["problemDescription"],
            snapshots.docs[i]["requestDate"],
            snapshots.docs[i]["longitude"],
            snapshots.docs[i]["latitude"],
            snapshots.docs[i]["user_id"],
            snapshots.docs[i]["user_name"],
            snapshots.docs[i]["mechanic_id"],
            snapshots.docs[i]["mechanic_shop_name"],
            snapshots.docs[i]["vehicle_reg_no"],
            snapshots.docs[i]["brand"],
            snapshots.docs[i]["model"],
          )
      );
    }
    return  quotations;
  }

  Future<bool> addRoadSideAssistance(MechanicRoadSideAssistance assistance) async {
    try{
      await assistanceCollection.add({
        "status" : assistance.status,
        "problemDescription" : assistance.problemDescription,
        "requestDate":assistance.requestDate,
        "longitude": assistance.longitude,
        "latitude":assistance.latitude,
        "user_id": assistance.userId,
        "user_name" : assistance.userName,
        "mechanic_id": assistance.mechanicId,
        "mechanic_shop_name" : assistance.mechanicShopName,
        "vehicle_reg_no" : assistance.vehicleRegNo,
        "brand" : assistance.brand,
        "model" : assistance.model,
      });
      return true;
    }catch(e){
      return false;
    }
  }

  Stream<List<MechanicRoadSideAssistance>> getUserAssistanceRequests(String uid) {
    return assistanceCollection
        .where('user_id',isEqualTo: uid)
        .snapshots().map((snapshot) => _quotationFromSnapshot(snapshot));
  }
}