import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mechanic_finder/models/task.dart';
import '../../../models/appUser.dart';
import '../../../services/auth.dart';
import '../../../shared/sideDrawer.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {

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
    final task = ModalRoute.of(context)!.settings.arguments as Task;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: Text("Task in " + task.mechanicShopName),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/tasks");
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
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: ListTile(
                            title: Text("Status : "+task.status.toUpperCase(),style: TextStyle(fontSize: 30),)
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
                        initialValue:task.vehicleRegNo,
                        enabled:false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,20,10,10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                          labelText: 'Task Description',
                        ),
                        initialValue:task.taskDescription,
                        minLines: 5,
                        maxLines: 7,
                        enabled:false,
                      ),
                    ),
                    if(task.status != 'decline' && task.estimatedCost > 0 )...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,20,10,0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                            ),
                            labelText: 'Estimated Cost',
                          ),
                          initialValue: 'Rs . ' + task.estimatedCost.toString(),
                          enabled:false,
                        ),
                      ),
                    ],
                    if(task.status == 'created')...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,20,10,0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                            ),
                            labelText: 'Appointment Date and Time',
                          ),
                          initialValue: DateFormat('yyyy-MM-dd HH:mm')
                              .format(task.appointmentDate).toString(),
                          enabled:false,
                        ),
                      ),
                    ],
                    if(task.status == 'start')...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,20,10,0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                            ),
                            labelText: 'Started Date and Time',
                          ),
                          initialValue: DateFormat('yyyy-MM-dd HH:mm')
                              .format(task.startedDate).toString(),
                          enabled:false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,20,10,0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                            ),
                            labelText: 'Estimate End Date and Time',
                          ),
                          initialValue: DateFormat('yyyy-MM-dd HH:mm')
                              .format(task.estimatedFinishedDate).toString(),
                          enabled:false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,20,10,0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                            ),
                            labelText: 'Completed Percentage',
                          ),
                          initialValue: task.completePercentage.toString(),
                          enabled:false,
                        ),
                      ),
                    ],
                    if(task.status == 'decline') ...[
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: ListTile(
                              leading: Icon(Icons.warning,color: Colors.red),
                              title: Text("Mechanic shop do not wish to "
                                  "proceed with your request at the moment",
                                style: TextStyle(color: Colors.red),)
                          ),
                        ),
                      )
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
