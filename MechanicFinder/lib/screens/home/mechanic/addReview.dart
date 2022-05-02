import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/mechanicReview.dart';
import 'package:mechanic_finder/services/mechanicService.dart';
import 'package:mechanic_finder/services/userService.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../models/appUser.dart';
import '../../../models/mechanic.dart';
import '../../../services/auth.dart';

class AddReviews extends StatefulWidget {
  const AddReviews({Key? key}) : super(key: key);

  @override
  State<AddReviews> createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  double rating = 1;
  String review = '';

  String error = '';
  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    final mechanic = ModalRoute.of(context)!.settings.arguments as Mechanic;
    return StreamBuilder<AppUserData>(
      stream: UserService(uid: appUser.uid).user,
      builder: (context, snapshot) {
        if(snapshot.data != null){
          AppUserData? data = snapshot.data;
          return Scaffold(
            backgroundColor: const Color.fromRGBO(231,248,238,1),
            appBar: AppBar(
              title: Text('New Review to '+mechanic.name),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined),
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    '/home-mechanic',
                    arguments:mechanic,
                  );
                },
              ),
              backgroundColor: Colors.green[600],
              elevation: 0.0,
            ),
            body:Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 70.0),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (val) {
                        setState(() {
                          rating = val;
                        });
                      },
                    ),
                    const SizedBox(height: 40.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the review': null,
                      onChanged: (val){
                        setState(()=> review = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Review',
                      ),
                      maxLines: 7,
                      minLines: 5,
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      child: const Text('Add',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      onPressed:() async {
                        if(_formKey.currentState!.validate()){
                          MechanicReview mechanicReview = MechanicReview('null',rating.round(),review,appUser.uid,data?.name ?? '');
                          bool success =  await MechanicService().addReview(mechanicReview,mechanic.id);
                          if(success){
                            Navigator.pushNamed(
                              context,
                              '/home-mechanic',
                              arguments:mechanic,
                            );
                          } else {
                            setState(() {
                              error = 'Adding the new review failed';
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            side: const BorderSide(color: Color.fromRGBO(46, 185, 160,1)),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(120,45)
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(46, 185, 160,1)),
                      ),
                    ),
                  ],
                )
              ),
            ) ,
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}
