import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/mechanic.dart';
import 'package:mechanic_finder/models/mechanicQuotation.dart';
import 'package:mechanic_finder/models/mechanicReview.dart';
import 'package:mechanic_finder/services/mechanicService.dart';
import 'package:mechanic_finder/shared/appCard.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../models/appointmentScreenArgs.dart';


class MechanicHome extends StatefulWidget {

  const MechanicHome({Key? key}) : super(key: key);

  @override
  State<MechanicHome> createState() => _MechanicHomeState();
}

class _MechanicHomeState extends State<MechanicHome> {

  @override
  Widget build(BuildContext context) {
    final mechanic = ModalRoute.of(context)!.settings.arguments as Mechanic;
    return StreamBuilder<List<MechanicReview>>(
      stream: MechanicService().getReviews(mechanic.id),
      builder: (context, snapshot) {
        if(snapshot.data != null){
          List<MechanicReview> reviews = snapshot.data ?? [];
          return Scaffold(
            backgroundColor: const Color.fromRGBO(231,248,238,1),
            appBar: AppBar(
              title: Text(mechanic.name),
              backgroundColor: Colors.green[600],
              elevation: 0.0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/find-mechanic");
                  }),
            ),
            body: Column(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.fromLTRB(10,20,10,0),
                  elevation: 4,
                  shadowColor: Colors.green,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.fromLTRB(10,0,10,0),
                    tileColor: Colors.blue,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    style: ListTileStyle.list,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: ListTile(
                      title: Text("Welcome to "+ mechanic.name, style: TextStyle(fontSize: 25),),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Owner : " + mechanic.owner),
                            const Text(" Rating : 5.0"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width)/2,
                      height: 88,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            '/road-side-assistance-mechanic',
                            arguments: mechanic,
                          );
                        },
                        child: const AppCard(details: 'Road Side Assistance',color:Colors.green)
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width)/2,
                      height: 88,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            '/quotation-mechanic',
                            arguments:mechanic,
                          );
                        },
                        child: const AppCard(details: 'Request a Quotation',color:Colors.blue)
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width)/2,
                      height: 88,
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(
                              context,
                              '/appointment-mechanic',
                              arguments:new AppointmentScreenArgs(mechanic, MechanicQuotation.empty())
                            );
                          },
                        child: const AppCard(details: 'Arrange Maintenance',color:Colors.blue),
                      ),

                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width)/2,
                      height: 88,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            '/review-mechanic',
                            arguments:mechanic,
                          );
                        },
                        child: const AppCard(details: 'Add Reviews',color:Colors.green)
                      ),
                    ),
                  ],
                ),
                Card(
                  margin: const EdgeInsets.fromLTRB(10,20,10,0),
                  elevation: 4,
                  shadowColor: Colors.green,
                  shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: const ListTile(
                    title: Text("User Reviews",style: TextStyle(fontSize: 20)),
                  ),
                ),
                Flexible(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context,index){
                        return Card(
                          margin: const EdgeInsets.fromLTRB(10,10,10,0),
                          elevation: 0,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: ListTileTheme(
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width: 1),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(reviews[index].user_name),
                                  Text("Ratings : "+reviews[index].rating.toString()),
                                ],
                              ),
                              subtitle: Text(reviews[index].review),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}

