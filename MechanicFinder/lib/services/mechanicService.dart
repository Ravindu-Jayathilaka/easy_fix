import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic_finder/models/mechanic.dart';
import 'package:mechanic_finder/models/mechanicReview.dart';

class MechanicService {
  String mechanicId = '';
  final CollectionReference mechanicCollection = FirebaseFirestore.instance.collection("mechanics");

  List<Mechanic> _mechanicsFromSnapshot(QuerySnapshot snapshots){
    List<Mechanic> mechanics = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      mechanics.add(
          Mechanic (
            snapshots.docs[i].id,
            snapshots.docs[i]["name"],
            snapshots.docs[i]["owner"],
            snapshots.docs[i]["latitude"],
            snapshots.docs[i]["longitude"],
          )
      );
    }
    return  mechanics;
  }

  List<MechanicReview> _reviewsFromSnapshot(QuerySnapshot snapshots){
    List<MechanicReview> reviews = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      reviews.add(
          MechanicReview (
            snapshots.docs[i].id,
            snapshots.docs[i]["rating"],
            snapshots.docs[i]["review"],
            snapshots.docs[i]["user_id"],
            snapshots.docs[i]["user_name"],
          )
      );
    }
    return  reviews;
  }

  Future<bool> addReview(MechanicReview review, String mechanic_id) async {
    try{
      await mechanicCollection.doc(mechanic_id).collection("reviews")
          .add({
        "rating": review.rating,
        "review": review.review,
        "user_id": review.user_id,
        "user_name": review.user_name,
      });
      return true;
    }catch(e){
      return false;
    }
  }

  Stream<List<Mechanic>> get mechanics {
    return mechanicCollection.snapshots()
        .map((snapshot) => _mechanicsFromSnapshot(snapshot));
  }

  Stream<List<MechanicReview>> getReviews(mechanic_id) {
    return mechanicCollection
        .doc(mechanic_id).collection("reviews")
        .snapshots().map((snapshot) => _reviewsFromSnapshot(snapshot));
  }

}