class AppUser {

  final String uid;

  AppUser({ required this.uid });
}

class AppUserData {
  final String uid;
  final String name;
  final String owner;
  final String email;
  final double latitude;
  final double longitude;
  String password='';

  AppUserData(this.uid, this.name, this.owner, this.email, this.latitude, this.longitude);

  AppUserData.screenArgs(this.uid, this.name, this.owner, this.email, this.latitude, this.longitude,this.password);

  AppUserData.empty(this.uid) :
  name='',
  owner='',
  email='',
  latitude=0,
  longitude=0;
}