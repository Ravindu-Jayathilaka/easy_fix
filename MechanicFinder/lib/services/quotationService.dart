import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mechanicQuotation.dart';

class QuotationService {
  final CollectionReference quotationCollection = FirebaseFirestore.instance.collection("quotation");

  List<MechanicQuotation> _quotationFromSnapshot(QuerySnapshot snapshots){
    List<MechanicQuotation> quotations = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      quotations.add(
          MechanicQuotation (
            snapshots.docs[i].id,
            snapshots.docs[i]["status"],
            snapshots.docs[i]["price"],
            snapshots.docs[i]["task"],
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

  Future<bool> addQuotation(MechanicQuotation quotation) async {
    try{
      await quotationCollection.add({
        "status" : quotation.status,
        "price" : quotation.price,
        "task" : quotation.task,
        "user_id": quotation.userId,
        "user_name" : quotation.userName,
        "mechanic_id": quotation.mechanicId,
        "mechanic_shop_name" : quotation.mechanicShopName,
        "vehicle_reg_no" : quotation.vehicleRegNo,
        "brand" : quotation.brand,
        "model" : quotation.model,
      });
      return true;
    }catch(e){
      return false;
    }
  }

  Stream<List<MechanicQuotation>> getUserQuotations(String uid) {
    return quotationCollection
        .where('user_id',isEqualTo: uid)
        .snapshots().map((snapshot) => _quotationFromSnapshot(snapshot));
  }
}