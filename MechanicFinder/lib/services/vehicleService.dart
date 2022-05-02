import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic_finder/models/vehicle.dart';
class VehicleService {

  final String uid;
  final CollectionReference vehicleCollection = FirebaseFirestore.instance.collection("vehicles");

  VehicleService({required this.uid});


  List<Vehicle> _vehicleFromSnapshot(QuerySnapshot snapshots){
    List<Vehicle> vehicles = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      vehicles.add(
        Vehicle (
          snapshots.docs[i].id,
          snapshots.docs[i]["brand"],
          snapshots.docs[i]["model"],
          snapshots.docs[i]["regNo"],
          snapshots.docs[i]["color"],
          snapshots.docs[i]["transmission"],
          snapshots.docs[i]["fuleType"],
          snapshots.docs[i]["mileage"],
        )
      );
    }
    return  vehicles;
  }

  List<String> _regNumbersFromSnapshot(QuerySnapshot snapshots){
    List<String> regNumbers = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      regNumbers.add(
        snapshots.docs[i]["regNo"],
      );
    }
    return  regNumbers;
  }

  Future<bool> updateVehicle(Vehicle vehicle) async {
    try{
      await vehicleCollection.doc(uid).collection("user_vehicles")
        .add({
          "brand": vehicle.brand,
          "model": vehicle.model,
          "regNo": vehicle.regNo,
          "color": vehicle.color,
          "transmission": vehicle.transmission,
          "fuleType": vehicle.fuleType,
          "mileage": vehicle.mileage,
        });
      return true;
    }catch(e){
      return false;
    }
  }

  Stream<List<Vehicle>> get vehicles {
    return vehicleCollection.doc(uid)
      .collection("user_vehicles")
      .snapshots().map((snapshot) => _vehicleFromSnapshot(snapshot));
  }

  Stream<List<String>> get vehicleNos {
    return vehicleCollection.doc(uid)
      .collection("user_vehicles")
      .snapshots().map((snapshot) => _regNumbersFromSnapshot(snapshot));
  }
}