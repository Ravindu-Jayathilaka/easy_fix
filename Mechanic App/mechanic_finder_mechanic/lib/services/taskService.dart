import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TaskService {

  final CollectionReference taskCollection = FirebaseFirestore.instance.collection("task");

  List<Task> _taskFromSnapshot(QuerySnapshot snapshots){
    List<Task> tasks = [];
    for( var i = 0 ; i < snapshots.docs.length; i++ ) {
      tasks.add(
        Task (
          snapshots.docs[i].id,
          snapshots.docs[i]["status"],
          snapshots.docs[i]["estimated_cost"],
          snapshots.docs[i]["task_description"],
          (snapshots.docs[i]["appointment_date"] as Timestamp).toDate(),
          (snapshots.docs[i]["started_date"] as Timestamp).toDate(),
          (snapshots.docs[i]["estimated_finished_date"] as Timestamp).toDate(),
          snapshots.docs[i]["user_id"],
          snapshots.docs[i]["user_name"],
          snapshots.docs[i]["mechanic_id"],
          snapshots.docs[i]["mechanic_shop_name"],
          snapshots.docs[i]["vehicle_reg_no"],
          snapshots.docs[i]["brand"],
          snapshots.docs[i]["model"],
          snapshots.docs[i]["complete_percentage"]
        )
      );
    }
    return  tasks;
  }

  Stream<List<Task>> getUserTasks(String uid) {
    return taskCollection
      .where('mechanic_id',isEqualTo: uid)
      .snapshots().map((snapshot) => _taskFromSnapshot(snapshot));
  }

  Stream<List<Task>> getAppointmentList(String uid) {
    return taskCollection
      .where('mechanic_id',isEqualTo: uid).where('status', whereIn:['created','accept'])
      .snapshots().map((snapshot) => _taskFromSnapshot(snapshot));
  }

  Stream<List<Task>> getOngoingTaskList(String uid) {
    return taskCollection
      .where('mechanic_id',isEqualTo: uid).where('status', whereIn:['start'])
      .snapshots().map((snapshot) => _taskFromSnapshot(snapshot));
  }

  Future<bool> updateAppointmentRequestStatus(String requestId, String status) async {
    try{
      await taskCollection.doc(requestId)
          .update({'status' : status});
      return true;
    }catch (e){
      return false;
    }
  }
}