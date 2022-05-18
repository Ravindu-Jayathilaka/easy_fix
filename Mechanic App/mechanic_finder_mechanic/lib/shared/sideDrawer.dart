import 'package:flutter/material.dart';
import '../models/appUser.dart';
import '../services/authService.dart';
import '../services/userService.dart';
import 'loading.dart';

class SideDrawer extends StatefulWidget {

  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
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
      builder: (context,snapshot) {
        AppUserData? userData = snapshot.data;
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.green,
          ),
          child: Drawer(
            child:Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(userData?.name ?? ''),
                  accountEmail: Text(userData?.email ?? ''),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      '${userData?.name.toUpperCase()[0]}',
                      style: const TextStyle(
                          fontSize: 40.0,
                          color: Colors.white
                      ),
                    ),
                    backgroundColor: Colors.blue[900],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue[700]
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Home',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      const Divider(
                        color: Colors.grey,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Settings',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        onTap: (){
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Sign Out',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        onTap: () async{
                          await _auth.signOut();
                        },
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        );
      }
    );
  }
}