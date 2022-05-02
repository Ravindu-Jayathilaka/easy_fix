import 'package:flutter/material.dart';
import 'package:mechanic_finder/services/vehicleService.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../models/appUser.dart';
import '../../../models/vehicle.dart';
import '../../../services/auth.dart';
import '../../../shared/sideDrawer.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({Key? key}) : super(key: key);

  @override
  State<Vehicles> createState() => _VehiclesState();

}

class _VehiclesState extends State<Vehicles> {

  final AuthService _auth = AuthService();
  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Vehicle>>(
      stream: VehicleService(uid:appUser.uid).vehicles,
      initialData: const [],
      builder: (context, snapshot) {
        if(snapshot.data != null){
          List<Vehicle> data = snapshot.data ?? [];
          return Scaffold(
            backgroundColor: const Color.fromRGBO(231,248,238,1),
            appBar: AppBar(
              title: const Text('My Vehicles'),
              backgroundColor: Colors.green[600],
              elevation: 0.0,
            ),
            drawer: const SideDrawer(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/add-vehicles");
              },
              backgroundColor: Colors.green[600],
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                return Card(
                  margin: const EdgeInsets.fromLTRB(10,10,10,0),
                  elevation: 4,
                  shadowColor: Colors.green,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: ListTileTheme(
                    tileColor: Colors.blue,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    style: ListTileStyle.list,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.directions_car, size: 45),
                      title: Text((data[index].brand)
                          + ' ' + (data[index].model)),
                      subtitle: Text(data[index].regNo),
                      onTap: (){
                        Navigator.pushNamed(
                          context,
                          '/view-vehicles',
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
