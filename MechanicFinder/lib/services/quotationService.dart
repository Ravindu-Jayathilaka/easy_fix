import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mechanicQuotation.dart';

class MechanicService {
  final CollectionReference quotationCollection = FirebaseFirestore.instance.collection("quotation");

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
}