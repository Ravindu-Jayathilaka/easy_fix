import 'package:flutter/material.dart';
import 'package:mechanic_finder/services/auth.dart';
import 'package:mechanic_finder/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({Key? key,required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String name = '';
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100.0),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: const [
                          Text("EASY",
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.green,
                              fontWeight: FontWeight.w800,
                            ),
                          ),Text(" FIX",
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter your name': null,
                      onChanged: (val){
                        setState(()=> name = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter an email': null,
                      onChanged: (val){
                        setState(()=> email = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextFormField(
                      obscureText: true,
                      validator: (val) => val!.length<6 ? 'Enter a password longer than 6 characters'
                          : null,
                      onChanged: (val){
                        setState(()=> password = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      child: const Text('Register',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      onPressed:() async {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmailAndPassword(email,password,name);
                          if(result == null){
                            setState(() => {
                              error = 'Please supply a valid email',
                              loading = false,
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            side: const BorderSide(color: Colors.green),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(120,45)
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(76, 175, 79,1)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red,fontSize: 14.0),
                    ),
                    Row(
                      children: <Widget>[
                        const Text("Already got an account ?",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: const Text('Log in'),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,//Center Row contents horizontally,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
