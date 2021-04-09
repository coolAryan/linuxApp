import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redlinux/cmd.dart';
import 'package:redlinux/reg.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => MyApp(),
        "/Reg": (context) => MyReg(),
        "/cmd":(context)=>MyCmd()
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Learn Linux',
          style: GoogleFonts.indieFlower(
            fontSize: 32,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          // Expanded(
          //     child: Container(
          //   height: 200,
          // )),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/redli.png'),
                ),
              ),
              height: MediaQuery.of(context).size.height * .4),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                topRight: Radius.circular(80),
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/linus.png'),
              ),
            ),
            height: MediaQuery.of(context).size.height * .4,
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/Reg"),
            child: Text(
              "Register",
              style: GoogleFonts.indieFlower(
                fontSize: 22,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
