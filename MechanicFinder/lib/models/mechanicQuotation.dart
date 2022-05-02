class MechanicQuotation{
  final String id;
  final String status; // created -> accept or decline -> finish
  final double price;
  final String task;
  final String userId;
  final String userName;
  final String mechanicId;
  final String mechanicShopName;
  final String vehicleRegNo;
  final String brand;
  final String model;

  MechanicQuotation(this.id, this.status, this.price, this.task,
      this.userId, this.userName, this.mechanicId, this.mechanicShopName,
      this.vehicleRegNo, this.brand, this.model);
}