import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/mechanicQuotation.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../models/appUser.dart';
import '../../../services/auth.dart';
import '../../../services/quotationService.dart';
import '../../../shared/sideDrawer.dart';

class Quotations extends StatefulWidget {
  const Quotations({Key? key}) : super(key: key);

  @override
  State<Quotations> createState() => _QuotationsState();

}

class _QuotationsState extends State<Quotations> {

  final AuthService _auth = AuthService();
  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MechanicQuotation>>(
      stream: QuotationService().getUserQuotations(appUser.uid),
      initialData: const [],
      builder: (context, snapshot) {
        if(snapshot.data != null){
          List<MechanicQuotation> data = snapshot.data ?? [];
          return Scaffold(
            backgroundColor: const Color.fromRGBO(231,248,238,1),
            appBar: AppBar(
              title: const Text('All Quotations'),
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
                      title: Text("Shop : " + (data[index].mechanicShopName)),
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
                          '/view-quotation',
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
