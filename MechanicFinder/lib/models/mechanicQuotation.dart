class MechanicQuotation{
   final String id;
   String status; // created -> accept or decline -> finish
   double price;
   String task;
   String userId;
   String userName;
   String mechanicId;
   String mechanicShopName;
   String vehicleRegNo;
   String brand;
   String model;

  MechanicQuotation(this.id, this.status, this.price, this.task,
      this.userId, this.userName, this.mechanicId, this.mechanicShopName,
      this.vehicleRegNo, this.brand, this.model);

  MechanicQuotation.empty():
     id='',
     status='created', // created -> accept or decline -> finish
     price=0,
     task='',
     userId='',
     userName='',
     mechanicId='',
     mechanicShopName='',
     vehicleRegNo='',
     brand='',
     model='';

  /****** -STATUS- *********/
  /*
  create - User create the quotation request
  accept - Mechanic accept the request and add the price.
   User can proceed to an appointment.
  decline - Mechanic decline the quotation due to unavailability
  finished - User can finish a task by just finishing
   or proceeding to appointment
   */
}