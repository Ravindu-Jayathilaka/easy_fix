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

  AppUserData(this.uid, this.name, this.owner, this.email, this.latitude, this.longitude);

  AppUserData.empty(this.uid) :
  name='',
  owner='',
  email='',
  latitude=0,
  longitude=0;
}