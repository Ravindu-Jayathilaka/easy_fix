import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic_finder/models/task.dart';

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
          snapshots.docs[i]["total_cost"],
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

  Future<bool> addTask(Task task) async {
    try{
      await taskCollection.add({
        'status': task.status,
        'estimated_cost': task.estimatedCost,
        'total_cost': task.totalCost,
        'task_description': task.taskDescription,
        'appointment_date': task.appointmentDate,
        'started_date': task.startedDate,
        'estimated_finished_date': task.estimatedFinishedDate,
        'user_id': task.userId,
        'user_name': task.userName,
        'mechanic_id': task.mechanicId,
        'mechanic_shop_name': task.mechanicShopName,
        'vehicle_reg_no' : task.vehicleRegNo,
        'brand': task.brand,
        'model': task.model,
        'complete_percentage': task.completePercentage,
      });
      return true;
    }catch(e){
      return false;
    }
  }

  Stream<List<Task>> getUserTasks(String uid) {
    return taskCollection
      .where('user_id',isEqualTo: uid)
      .snapshots().map((snapshot) => _taskFromSnapshot(snapshot));
  }
}