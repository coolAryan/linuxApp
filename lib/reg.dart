import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool sspin = false;

class MyReg extends StatefulWidget {
  @override
  _MyRegState createState() => _MyRegState();
}

class _MyRegState extends State<MyReg> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    FirebaseAuth authc = FirebaseAuth.instance;

    final email = TextEditingController();
    final pswd = TextEditingController();
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: sspin,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                child: Icon(
                  Icons.arrow_upward_sharp,
                  size: 50,
                ),
                backgroundColor: Colors.amberAccent.shade200,
                radius: 40,
              ),
              color: Colors.white,
            ),
            Container(
              height: 600,
              width: 900,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade200,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(bottom: 40),
                    child: Text(
                      'Login|SignUp',
                      style: GoogleFonts.lato(
                        fontSize: 44,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    padding: EdgeInsets.all(30.0),
                    child: TextField(
                      // onChanged: (value) {
                      //   email = value;
                      // },
                      controller: email,
                      autocorrect: false,
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'username',
                        border: OutlineInputBorder(
                          // borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    padding: EdgeInsets.all(30.0),
                    child: TextField(
                      // onChanged: (value) {
                      //   pswd = value;
                      // },
                      controller: pswd,
                      obscureText: true,
                      cursorColor: Colors.orange.shade300,
                      autocorrect: false,
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.remove_red_eye),
                        hintText: 'password',
                        border: OutlineInputBorder(
                          // borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 22),
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.lato(),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(98, 68),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      try {
                        setState(() {
                          sspin = true;
                        });
                        var user = await authc.createUserWithEmailAndPassword(
                            email: email.text, password: pswd.text);
                        // ignore: unnecessary_statements
                        //user.additionalUserInfo.isNewUser;
                        
                        if (user != null) {
                          Navigator.pushNamed(context, "/cmd");
                          // setState(() {
                          //   sspin = false;
                          // });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.blue.shade400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
