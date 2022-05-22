import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mechanic_finder_mechanic/services/taskService.dart';
import '../../../models/appUser.dart';
import '../../../shared/sideDrawer.dart';
import '../../models/task.dart';
import '../../services/authService.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {

  final AuthService _auth = AuthService();

  String status = '';

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
    setState(() {
      status = status.trim() == '' ? task.status : status;
    });
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: Text(((status == 'created' || status == 'accept')
            ?"Appointment of ": "Task of ") + task.userName),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              if(status == 'created' || status == 'accept'){
                Navigator.pushReplacementNamed(context, "/appointments");
              } else if (status == 'start'){
                Navigator.pushReplacementNamed(context, "/ongoing-tasks");
              } else {
                Navigator.pushReplacementNamed(context, "/tasks");
              }
            }),
        backgroundColor: Colors.green[600],
        elevation: 0.0,
      ),
      drawer: const SideDrawer(),
      body:SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Form(
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
                          title: Text("Status : " + status.toUpperCase(),style: const TextStyle(fontSize: 30),)
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
                  if(status != 'decline' && task.estimatedCost > 0 )...[
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
                  if(status == 'created' || status == 'accept')...[
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
                  if(status == 'created')...[
                    const SizedBox(height: 20.0),
                    Text(error, style: const TextStyle(color: Colors.red),),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text('Accept', style: TextStyle(
                              color: Colors.white, fontSize: 20.0),),
                          onPressed: () async {
                            bool success = await TaskService()
                                .updateAppointmentRequestStatus(task.id,'accept');
                            if(success){
                              setState(() {
                                status = 'accept';
                                error = '';
                              });
                            } else {
                              error = 'Error in accepting the request';
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                side: const BorderSide(
                                    color: Color.fromRGBO(
                                        46, 185, 160, 1)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(120, 45)
                            ),
                            backgroundColor: MaterialStateProperty.all<
                                Color>(
                                const Color.fromRGBO(46, 185, 160, 1)),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        ElevatedButton(
                          child: const Text('Decline', style: TextStyle(
                              color: Colors.white, fontSize: 20.0),),
                          onPressed: () async {
                            bool success = await TaskService()
                                .updateAppointmentRequestStatus(task.id,'decline');

                            if(success){
                              setState(() {
                                status = 'decline';
                                error = '';
                              });
                            } else {
                              error = 'Error in decline the request';
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                side: const BorderSide(
                                    color: Color.fromRGBO(
                                        252, 5, 5, 1)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(120, 45)
                            ),
                            backgroundColor: MaterialStateProperty.all<
                                Color>(
                                const Color.fromRGBO(252, 5, 5, 1)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  if(status == 'start')...[
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
                  if(status == 'decline') ...[
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                            leading: Icon(Icons.warning,color: Colors.red),
                            title: Text("You have rejected this request",
                              style: TextStyle(color: Colors.red),)
                        ),
                      ),
                    )
                  ]
                ],
              )
            )
          ],
        ),
      ) ,
    );
  }
}
