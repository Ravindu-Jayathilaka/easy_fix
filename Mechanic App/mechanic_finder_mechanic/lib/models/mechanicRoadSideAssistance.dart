class MechanicRoadSideAssistance {
  final String id;
  final String status; // created -> accept or decline -> finish
  final String problemDescription;
  final DateTime requestDate;
  final double longitude;
  final double latitude;
  final String userId;
  final String userName;
  final String mechanicId;
  final String mechanicShopName;
  final String vehicleRegNo;
  final String brand;
  final String model;

  MechanicRoadSideAssistance(this.id, this.status, this.problemDescription,
      this.requestDate, this.longitude, this.latitude, this.userId,
      this.userName, this.mechanicId, this.mechanicShopName,
      this.vehicleRegNo, this.brand, this.model);

/****** -STATUS- *********/
/*
  created - User create the assistance request
  accept - Mechanic accept the request and is on the way.
  decline - Mechanic decline the request due to unavailability
  done - Mechanic finish the process and user can pay
  finished - User can finish a task or doing the payment.
   */
}