import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mechanic_finder_mechanic/services/taskService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../models/appUser.dart';
import '../../../shared/sideDrawer.dart';
import '../../models/task.dart';
import '../../services/authService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {

  final AuthService _auth = AuthService();
  String status = '';
  String error = '';
  final _acceptFormKey = GlobalKey<FormState>();
  final _startFormKey = GlobalKey<FormState>();
  final _doneFormKey = GlobalKey<FormState>();
  late AppUser appUser;
  double estimatedCost = 0;
  double totalCost = 0;
  DateTime startDateTime = DateTime.now();
  DateTime finishDateTime = DateTime.now();
  DateTime? startStateFinishDate = null;
  var startDateAndTimeController = TextEditingController();
  var finishDateAndTimeController = TextEditingController();
  var startStateFinishDateController = TextEditingController();
  int completePersentage = 0;

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
    if(status =='start' && startStateFinishDate == null) {
      startStateFinishDateController.text = DateFormat('yyyy-MM-dd HH:mm')
          .format(task.estimatedFinishedDate).toString();
      startStateFinishDate = task.estimatedFinishedDate;
    }
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
            Column(
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
                if((status == 'created')
                && task.estimatedCost > 0 )...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,20,10,0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefix:Text("Rs "),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        labelText: 'Estimated Cost From Quotation',
                      ),
                      initialValue:task.estimatedCost.toString(),
                      enabled:false,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
                if(status == 'created')...[
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
                if(status == 'accept')...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10,20,10,10),
                      child: Text('Start repairing this vehicle ?',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))
                  ),
                  Form(
                    key:_acceptFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,20,10,0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefix:Text("Rs "),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                              labelText: 'Estimated Cost',
                            ),
                            initialValue: task.estimatedCost.toString(),
                            validator: (val) =>
                            !(double.parse(val!) > 0)
                                ? 'Enter the estimated cost'
                                : null,
                            onChanged: (val) {
                              setState(() => estimatedCost = double.parse(val));
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,20,10,0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Start Date and Time',
                            ),
                            readOnly: true,
                            controller: startDateAndTimeController,
                            validator: (val) =>
                            val!.isEmpty
                                ? 'Select the start Date'
                                : null,
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(DateTime.now().year,DateTime.now().month+1,DateTime.now().day),
                                  theme: const DatePickerTheme(
                                      headerColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      itemStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle:
                                      TextStyle(color: Colors.white, fontSize: 16)),
                                  onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  },
                                  onConfirm: (date) {
                                    setState(() {
                                      startDateTime = date;
                                    });
                                    startDateAndTimeController.text = DateFormat('yyyy-MM-dd HH:mm')
                                        .format(date).toString();
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,20,10,10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Estimated finish Date',
                            ),
                            readOnly: true,
                            controller: finishDateAndTimeController,
                            validator: (val) =>
                            val!.isEmpty
                                ? 'Select the finish date'
                                : null,
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(DateTime.now().year,DateTime.now().month+1,DateTime.now().day),
                                  theme: const DatePickerTheme(
                                      headerColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      itemStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle:
                                      TextStyle(color: Colors.white, fontSize: 16)),
                                  onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  },
                                  onConfirm: (date) {
                                    setState(() {
                                      finishDateTime = date;
                                    });
                                    finishDateAndTimeController.text = DateFormat('yyyy-MM-dd HH:mm')
                                        .format(date).toString();
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(error, style: const TextStyle(color: Colors.red),),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('Start', style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),),
                              onPressed: () async {
                                if (_acceptFormKey.currentState!.validate()) {
                                  estimatedCost = estimatedCost == 0 ? task.estimatedCost : estimatedCost;
                                  bool success = await TaskService()
                                      .updateTaskStatusToStart(task.id,estimatedCost,startDateTime,finishDateTime);
                                  if(success){
                                    setState(() {
                                      status = 'start';
                                      error = '';
                                    });
                                  } else {
                                    error = 'Error in accepting the request';
                                  }
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
                    )
                  )
                ],
                if(status == 'start')...[
                  Form(
                    key: _startFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,20,10,0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefix:Text("Rs "),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                              labelText: 'Estimated Cost',
                            ),
                            initialValue: task.estimatedCost.toString(),
                            validator: (val) =>
                            !(double.parse(val!) > 0)
                                ? 'Enter the estimated cost'
                                : null,
                            onChanged: (val) {
                              setState(() => estimatedCost = double.parse(val));
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
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
                          padding: const EdgeInsets.fromLTRB(10,20,10,10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                              labelText: 'Estimated Finish Date',
                            ),
                            readOnly: true,
                            controller: startStateFinishDateController,
                            validator: (val) =>
                            val!.isEmpty
                                ? 'Select the finish date'
                                : null,
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(DateTime.now().year,DateTime.now().month+1,DateTime.now().day),
                                  theme: const DatePickerTheme(
                                      headerColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      itemStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle:
                                      TextStyle(color: Colors.white, fontSize: 16)),
                                  onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  },
                                  onConfirm: (date) {
                                    setState(() {
                                      startStateFinishDate = date;
                                    });
                                    startStateFinishDateController.text = DateFormat('yyyy-MM-dd HH:mm')
                                        .format(date).toString();
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,20,10,0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border : OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                              labelText: 'Completed Percentage',
                            ),
                            initialValue: task.completePercentage.toString(),
                            onChanged: (val) {
                              setState(() => completePersentage = int.parse(val));
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('Update', style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),),
                              onPressed: () async {
                                if (_startFormKey.currentState!.validate()) {
                                  estimatedCost = estimatedCost == 0 ? task.estimatedCost : estimatedCost;
                                  bool success = await TaskService()
                                      .updateTaskStatusStart(task.id,estimatedCost,completePersentage,startStateFinishDate!);
                                  if(success){
                                    Fluttertoast.showToast(
                                        msg: "Updated Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP_LEFT,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  } else {
                                    error = 'Error in accepting the request';
                                  }
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
                              child: const Text('Done', style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),),
                              onPressed: () async {
                                _openPopup(context,task.id);
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
                          ],
                        ),
                        const SizedBox(height: 20,),
                      ],
                    )
                  ),
                ],
                if(status == 'done') ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,20,10,0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefix:Text("Rs "),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        labelText: 'Total Cost',
                      ),
                      initialValue: task.totalCost == 0 ? totalCost.toString()
                                  :task.totalCost.toString(),
                      enabled: false,
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
          ],
        ),
      ) ,
    );
  }


  _openPopup(context,taskId) {
    Alert(
        context: context,
        title: "Complete the Task",
        content: Column(
          children: <Widget>[
            Form(
              key: _doneFormKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,20,10,0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefix:Text("Rs "),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    hintText: 'Total Cost',
                  ),
                  validator: (val) =>
                  !(val?.trim() !='' && double.parse(val!) > 0)
                      ? 'Enter the total cost'
                      : null,
                  onChanged: (val) {
                    setState(() => totalCost = double.parse(val));
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() async {
              if(_doneFormKey.currentState!.validate()){
                bool success = await TaskService()
                    .updateTaskStatusToDone(taskId,totalCost);
                if(success){
                  setState(() {
                    status = 'done';
                    error = '';
                  });
                  Navigator.pop(context);
                } else {
                  error = 'Error in update the request';
                }
              }
            },
            child: const Text(
              "Done",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
          )
        ]).show();
  }
}
