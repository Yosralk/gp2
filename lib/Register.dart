import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'Const.dart';
import 'firebase/authserves.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  String? email;
  String? pass;
  static String? FullName;
  static final TextEditingController controllerName = TextEditingController();//new
  //
  TextEditingController controllername= TextEditingController();
  // TextEditingController controllerPass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                  "https://img.freepik.com/premium-vector/fire-flame-vector-illustration_1948-16761.jpg?w=826"),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (e) {
                        setState(() {
                          email = e;
                        });
                      },

                      decoration: decoration(
                          txtLabel: "Email", txt: "Ahmad@gmaile.com"),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      onSaved: (p) {
                        setState(() {
                          pass = p;
                        });
                      },
                      //controller:controllerPass1,
                      //validator: (txt) {
                      // if (txt!.isEmpty) {
                      //   return "please enter password";
                      // }
                      // else if(txt.length<8){
                      //   return "please enter 8 charecters or more";
                      // }
                      // else if(!(PasswordValidator(txt))){
                      //   return "Password not valid";
                      //
                      // }
                      // return null;
                      //},

                      decoration: decoration(
                          txtLabel: "password", txt: "as23%A#m"),

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      //controller: controllername,
                      onSaved: (F) {
                        setState(() {
                          FullName=F;
                        });
                      },

                      decoration: decoration(
                          txtLabel: "Full Name", txt: "Mohammad Ali"),
                    ),

                    SizedBox(height: 30,),
                    // ... other form fields
                    ElevatedButton(
                      onPressed: () {
                        _formkey.currentState!.save();

                        SignUp();
                        Navigator.of(context).pushNamed(route2);

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text("Register", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(350, 50),
                      ),

                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      signInWithGoogle();

                    }, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text("Register with google", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),),
                    ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(350, 50),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have account ?", style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),),
                        TextButton(onPressed: () {
                          Navigator.of(context).pushNamed(route2);
                        },
                            child: Text("Sign in", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),))
                      ],
                    )
                  ],
                ),
              ),
            ]
            ,
          ),
        ),
      ),

    );
  }


  InputDecoration decoration({required String txt, required String txtLabel}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(
          color: Colors.white,
          width: 50,


        ),


      ),
      label: Text(txtLabel),
      labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.black,


          )
      )
      ,
      hintText: txt,
      hintStyle: TextStyle(color: Colors.black),

      floatingLabelBehavior: FloatingLabelBehavior.never,
    );


  }
  SignUp() async {
    AuthProcess authProcess = await AuthServicess.register(email!, pass!,controllerName.text);
    if(authProcess.isValid==true){
      Navigator.of(context).pushReplacementNamed(route2);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(authProcess.errorMsg),));
    }
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}