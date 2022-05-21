import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mechanic_finder/models/screenArgs/appointmentScreenArgs.dart';
import 'package:mechanic_finder/models/vehicle.dart';
import 'package:mechanic_finder/services/taskService.dart';
import 'package:mechanic_finder/services/userService.dart';
import 'package:mechanic_finder/services/vehicleService.dart';
import 'package:mechanic_finder/shared/loading.dart';
import 'package:intl/intl.dart';

import '../../../models/appUser.dart';
import '../../../models/task.dart';
import '../../../services/auth.dart';

class RequestAppointment extends StatefulWidget {
  const RequestAppointment({Key? key}) : super(key: key);

  @override
  State<RequestAppointment> createState() => _RequestAppointmentState();
}

class _RequestAppointmentState extends State<RequestAppointment> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String taskDescription = '';
  String? vhlRegNo;
  String vhlBrand = '';
  String vhlModel = '';
  DateTime appointmentDateTime = DateTime.now();

  String error = '';
  late AppUser appUser;

  var brandController = TextEditingController();
  var modelController = TextEditingController();
  var dateAndTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
      .of(context)!
      .settings
      .arguments as AppointmentScreenArgs;
    final mechanic = args.mechanic;
    final quotation = args.quotation;

    if(quotation.vehicleRegNo.trim() != ''
        && vhlRegNo == null){
      setState(() {
        vhlRegNo=quotation.vehicleRegNo;
        vhlBrand = quotation.brand;
        vhlModel = quotation.model;
        taskDescription = quotation.task;
      });
      modelController.text = quotation.model;
      brandController.text = quotation.brand;
    }

    return StreamBuilder<AppUserData>(
      stream: UserService(uid: appUser.uid).user,
      builder: (context, userSnapshot) {
        return StreamBuilder(
          stream: VehicleService(uid: appUser.uid).vehicles,
          builder: (context, vehicleSnapshot) {
            if (vehicleSnapshot.data != null) {
              AppUserData? userData = userSnapshot.data;
              List<String> dropDownValueList = [];
              List<Vehicle>? vehicleList = vehicleSnapshot.data as List<Vehicle>?;
              vehicleList?.forEach((element) {dropDownValueList.add(element.regNo);});
              return Scaffold(
                backgroundColor: const Color.fromRGBO(231, 248, 238, 1),
                appBar: AppBar(
                  title: Text('Appointment to ' + mechanic.name),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      if(quotation.id.trim() != ''){
                        Navigator.pushNamed(
                          context,
                          '/quotations'
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/home-mechanic',
                          arguments: mechanic,
                        );
                      }
                    },
                  ),
                  backgroundColor: Colors.green[600],
                  elevation: 0.0,
                ),
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 25.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 40.0),
                              InputDecorator(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: vhlRegNo,
                                    hint: const Text('Select the Vehicle'),
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        vhlRegNo = newValue!;
                                      });
                                      vehicleList?.forEach((element) {
                                        if(element.regNo == newValue){
                                          modelController.text = element.model;
                                          brandController.text = element.brand;
                                          setState(() {
                                            vhlBrand = element.brand;
                                            vhlModel = element.model;
                                          });
                                        }
                                      });
                                    },
                                    items: <String>[...dropDownValueList]
                                        .map<DropdownMenuItem<String>>((
                                        String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Vehicle Brand',
                                ),
                                readOnly: true,
                                controller: brandController,
                                validator: (val) =>
                                val!.isEmpty
                                    ? 'Select the Vehicle'
                                    : null,
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Vehicle Model',
                                ),
                                readOnly: true,
                                controller: modelController,
                                validator: (val) =>
                                val!.isEmpty
                                    ? 'Select the Vehicle'
                                    : null,
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Date and Time',
                                ),
                                readOnly: true,
                                controller: dateAndTimeController,
                                validator: (val) =>
                                val!.isEmpty
                                  ? 'Select the time and date'
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
                                        appointmentDateTime = date;
                                      });
                                      dateAndTimeController.text = DateFormat('yyyy-MM-dd HH:mm')
                                          .format(date).toString();
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en
                                  );
                                },
                              ),
                              const SizedBox(height: 40.0),
                              TextFormField(
                                initialValue: quotation.task,
                                validator: (val) =>
                                val!.isEmpty
                                    ? 'Enter the description'
                                    : null,
                                onChanged: (val) {
                                  setState(() => taskDescription = val);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Task Description',
                                ),
                                maxLines: 7,
                                minLines: 5,
                              ),
                              const SizedBox(height: 30.0),
                              const SizedBox(height: 30.0),
                              ElevatedButton(
                                child: const Text('Add', style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Task task = Task('','created',0,taskDescription,appointmentDateTime,appointmentDateTime,
                                        appointmentDateTime, appUser.uid,userData?.name ?? '', mechanic.id,
                                        mechanic.name,vhlRegNo!,vhlBrand,vhlModel,0);
                                    bool success = await TaskService()
                                        .addTask(task);
                                    if (success) {
                                      Navigator.pushNamed(
                                        context,
                                        '/tasks',
                                        arguments: mechanic,
                                      );
                                    } else {
                                      setState(() {
                                        error = 'Adding the new review failed';
                                      });
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
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else {
              return const Loading();
            }
          }
        );
      }
    );
  }
}