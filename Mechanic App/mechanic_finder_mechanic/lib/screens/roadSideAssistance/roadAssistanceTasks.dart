import 'package:flutter/material.dart';

import '../../../models/appUser.dart';
import '../../../shared/sideDrawer.dart';
import '../../models/mechanicRoadSideAssistance.dart';
import '../../services/authService.dart';
import '../../services/roadSideAssistanceService.dart';
import '../../shared/loading.dart';

class RoadAssistanceTasks extends StatefulWidget {
  const RoadAssistanceTasks({Key? key}) : super(key: key);

  @override
  State<RoadAssistanceTasks> createState() => _RoadAssistanceTasksState();

}

class _RoadAssistanceTasksState extends State<RoadAssistanceTasks> {

  final AuthService _auth = AuthService();
  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MechanicRoadSideAssistance>>(
      stream: RoadSideAssistanceService().getUserAssistanceRequests(appUser.uid),
      initialData: const [],
      builder: (context, snapshot) {
        List<MechanicRoadSideAssistance> data = snapshot.data ?? [];
        if(data != null) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(231,248,238,1),
            appBar: AppBar(
              title: const Text('All Roadside Assistance Tasks'),
              backgroundColor: Colors.green[600],
              elevation: 0.0,
            ),
            drawer: const SideDrawer(),
            body: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                return Card(
                  margin: const EdgeInsets.fromLTRB(10,10,10,0),
                  elevation: 4,
                  shadowColor: Colors.green,
                  shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: ListTileTheme(
                    tileColor: Colors.blue,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    style: ListTileStyle.list,
                    shape: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: ListTile(
                      title: Text("Customer : " + (data[index].userName)),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Vehicle : " + data[index].vehicleRegNo),
                            Text(" Status : " + data[index].status),
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.pushNamed(
                          context,
                          '/view-road-side-assistance',
                          arguments:data[index],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}
