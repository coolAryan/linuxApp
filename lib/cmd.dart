import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

var webdata;
String order;
var d;

class MyCmd extends StatefulWidget {
  @override
  _MyCmdState createState() => _MyCmdState();
}

class _MyCmdState extends State<MyCmd> {
  @override
  Widget build(BuildContext context) {
    var fs = FirebaseFirestore.instance.collection("Commands");

    web(order) async {
      // var url =    'http://192.168.43.218/cgi-bin/net.py?q=$os&x=$image&z=$remove&y=$list&w=$pull&v=$container';

      var response = await http.get(
          Uri.http("192.168.43.218:80", "/cgi-bin/linus.py", {"r": "$order"}));
      print(response.body);

      setState(() {
        webdata = response.body;
      });
      fs.add({"$order": "$webdata"});

      print(webdata);
      print(response.statusCode);
    }

    mydata() async {
       d = await fs.get();
      print(d.docs);

      setState(() {
        for (var i in d.docs) {

          print(i.data());
        }
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 500,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.brown, width: 18),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 500,
                    alignment: Alignment.center,
                    child: Text(
                      webdata ?? "hello",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              cursorColor: Colors.orange.shade300,
              onChanged: (value) {
                order = value;
                // container = 'docker attach $container ';
              },
              autocorrect: false,
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                hintText: 'Enter cmd',
                border: OutlineInputBorder(
                  // borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.add_box,
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  web(order);
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  mydata();
                },
                child: Text('Reterieve data'),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
            ),
            Container(
                    height: 500,
                    alignment: Alignment.center,
                    child: Text(
                      "retrieved data",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 23,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
