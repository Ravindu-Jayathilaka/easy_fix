import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mechanicRoadSideAssistance.dart';


class RoadSideAssistanceService {
  final CollectionReference assistanceCollection = FirebaseFirestore.instance.collection("road_side_assistance");

  List<MechanicRoadSideAssistance> _assistanceRequestsFromSnapshot(QuerySnapshot snapshots){
    List<MechanicRoadSideAssistance> quotations = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      quotations.add(
          MechanicRoadSideAssistance(
            snapshots.docs[i].id,
            snapshots.docs[i]["status"],
            snapshots.docs[i]["problem_description"],
            (snapshots.docs[i]["request_date"] as Timestamp).toDate(),
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

  Stream<List<MechanicRoadSideAssistance>> getUserAssistanceRequests(String uid) {
    return assistanceCollection
        .where('mechanic_id',isEqualTo: uid)
        .snapshots().map((snapshot) => _assistanceRequestsFromSnapshot(snapshot));
  }

  Stream<List<MechanicRoadSideAssistance>> getUserOngoingAssistanceRequests(String uid) {
    return assistanceCollection
        .where('mechanic_id',isEqualTo: uid).where('status', whereIn:['created','accept'])
        .snapshots().map((snapshot) => _assistanceRequestsFromSnapshot(snapshot));
  }

  Future<bool> updateAssistanceRequestStatus(String requestId, String status) async {
    try{
      await assistanceCollection.doc(requestId)
          .update({'status' : status});
      return true;
    }catch (e){
      return false;
    }
  }
}