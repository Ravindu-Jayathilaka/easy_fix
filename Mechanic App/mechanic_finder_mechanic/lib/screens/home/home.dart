import 'package:flutter/material.dart';

import '../../models/appUser.dart';
import '../../models/mechanicRoadSideAssistance.dart';
import '../../services/authService.dart';
import '../../services/roadSideAssistanceService.dart';
import '../../services/userService.dart';
import '../../shared/sideDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUserData>(
        stream: UserService(uid:appUser.uid).user,
        builder: (context, snapshot) {
          AppUserData appUserData
          = snapshot.data ?? AppUserData.empty(appUser.uid);
          List<String> name = appUserData.owner.split(" ");
          return StreamBuilder<List<MechanicRoadSideAssistance>>(
            stream: RoadSideAssistanceService().getUserOngoingAssistanceRequests(appUser.uid),
            builder: (context, snapshot) {
              List<MechanicRoadSideAssistance> assistanceList = snapshot.data ?? [];
              return Scaffold(
                backgroundColor: const Color.fromRGBO(231,248,238,1),
                appBar: AppBar(
                  title: const Text('Mechanic Finder'),
                  backgroundColor: Colors.green[600],
                  elevation: 0.0,
                ),
                drawer: const SideDrawer(),
                body: Column(
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
                            title: Text("Welcome "+name[0],style: TextStyle(fontSize: 30),)
                        ),
                      ),
                    ),
                    if(assistanceList.isNotEmpty)...[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10,30,10,10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ongoing Assistance Requests",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: assistanceList.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Card(
                            margin: const EdgeInsets.fromLTRB(10,10,10,0),
                            elevation: 4,
                            shadowColor: Colors.blue,
                            shape: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue, width: 1),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: ListTileTheme(
                              tileColor: Colors.white,
                              iconColor: Colors.black,
                              textColor: Colors.black,
                              style: ListTileStyle.list,
                              shape: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.blue, width: 1),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: ListTile(
                                title: Text("Shop : " + (assistanceList[index].mechanicShopName)),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Vehicle : " + assistanceList[index].vehicleRegNo),
                                      Text(" Status : " + assistanceList[index].status),
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(
                                    context,
                                    '/view-road-side-assistance',
                                    arguments:assistanceList[index],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              );
            }
          );
        }
    );
  }
}
