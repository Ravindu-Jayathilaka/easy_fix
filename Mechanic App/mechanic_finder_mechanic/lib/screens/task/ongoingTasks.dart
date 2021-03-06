import 'package:flutter/material.dart';
import '../../../models/appUser.dart';
import '../../../shared/sideDrawer.dart';
import '../../models/task.dart';
import '../../services/authService.dart';
import '../../services/taskService.dart';

class OngoingTasks extends StatefulWidget {
  const OngoingTasks({Key? key}) : super(key: key);

  @override
  State<OngoingTasks> createState() => _OngoingTasksState();

}

class _OngoingTasksState extends State<OngoingTasks> {

  final AuthService _auth = AuthService();
  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: TaskService().getOngoingTaskList(appUser.uid),
      initialData: const [],
      builder: (context, snapshot) {
        List<Task> data = snapshot.data ?? [];
        return Scaffold(
          backgroundColor: const Color.fromRGBO(231,248,238,1),
          appBar: AppBar(
            title: const Text('Ongoing Tasks'),
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
                        '/view-tasks',
                        arguments:data[index],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
