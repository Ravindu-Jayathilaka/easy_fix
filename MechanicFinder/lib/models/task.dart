class Task{
  final String id;
  final String status; // created -> accept or decline -> finish
  final double estimatedCost;
  final String taskDescription;
  final DateTime appointmentDate;
  final DateTime startedDate;
  final DateTime estimatedFinishedDate;
  final String userId;
  final String userName;
  final String mechanicId;
  final String mechanicShopName;
  final String vehicleRegNo;
  final String brand;
  final String model;
  final int completePercentage;

  Task(this.id, this.status, this.estimatedCost, this.taskDescription,
      this.appointmentDate, this.startedDate, this.estimatedFinishedDate,
      this.userId, this.userName, this.mechanicId, this.mechanicShopName,
      this.vehicleRegNo, this.brand, this.model,this.completePercentage);

/****** -STATUS- *********/
/*
  create - User create the appointment request
  accept - Mechanic accept the request and add the price
   if it is not there.
  decline - Mechanic decline the appointment due to unavailability
  start - task is ongoing.
  finished - task is finished. Proceed to payment.
   */
}