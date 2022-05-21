import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/screenArgs/appointmentScreenArgs.dart';
import 'package:mechanic_finder/models/mechanicQuotation.dart';
import 'package:mechanic_finder/services/mechanicService.dart';
import '../../../models/appUser.dart';
import '../../../models/mechanic.dart';
import '../../../services/auth.dart';
import '../../../shared/sideDrawer.dart';

class ViewQuotation extends StatefulWidget {
  const ViewQuotation({Key? key}) : super(key: key);

  @override
  State<ViewQuotation> createState() => _ViewQuotationState();
}

class _ViewQuotationState extends State<ViewQuotation> {

  final AuthService _auth = AuthService();

  String status = ''; // created -> accept or decline -> finish
  double price = 0;
  String task  = '';
  String userName  = '';
  String mechanicShopName = '';
  String vehicleRegNo = '' ;
  String brand = '';
  String model = '';

  String error = '';

  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    final quotation = ModalRoute.of(context)!.settings.arguments as MechanicQuotation;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: Text("Quotation of " + quotation.mechanicShopName),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/quotations");
            }),
        backgroundColor: Colors.green[600],
        elevation: 0.0,
      ),
      drawer: const SideDrawer(),
      body:SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Form(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.fromLTRB(10,20,10,0),
                      elevation: 4,
                      shadowColor: Colors.green,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: ListTileTheme(
                        contentPadding: const EdgeInsets.all(10),
                        tileColor: Colors.blue,
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        style: ListTileStyle.list,
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: ListTile(
                            title: Text("Status : "+quotation.status.toUpperCase(),style: TextStyle(fontSize: 30),)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,20,10,0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                          labelText: 'Vehicle',
                        ),
                        initialValue:quotation.vehicleRegNo,
                        enabled: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,20,10,10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                          labelText: 'Task',
                        ),
                        initialValue:quotation.task,
                        enabled: false,
                        minLines: 5,
                        maxLines: 7,
                      ),
                    ),
                    if(quotation.status == 'accept')...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,20,10,20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                            ),
                            labelText: 'Price',
                          ),
                          initialValue:'Rs. ' + quotation.price.toString(),
                          enabled: false,
                        ),
                      ),
                      ElevatedButton(
                        child: const Text('Proceed',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                        onPressed:() async {
                          Mechanic mechanicDetails = await MechanicService().getMechanicFromId(quotation.mechanicId);
                          Navigator.pushReplacementNamed(context, "/appointment-mechanic",
                              arguments: new AppointmentScreenArgs(mechanicDetails, quotation));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                              side: const BorderSide(color: Color.fromRGBO(46, 185, 160,1)),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(120,45)
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(46, 185, 160,1)),
                        ),
                      ),
                    ],
                    if(quotation.status == 'decline') ...[
                      const Text('Mechanic shop do not wish to '
                          'proceed with your request at the moment',
                      style: TextStyle(color: Colors.red),)
                    ]
                  ],
                )
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
