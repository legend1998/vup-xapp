import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                //go back
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.blue,
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.blue,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ))
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                    title: Text("Name"),
                    subtitle: Text("john doe "),
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.edit)),
                ListTile(
                    title: Text("Mobile Number"),
                    subtitle: Text("9999999999"),
                    leading: Icon(Icons.mobile_friendly),
                    trailing: Icon(Icons.edit)),
                ListTile(
                    title: Text("E-mail"),
                    subtitle: Text("john.doe@gmail.com"),
                    leading: Icon(Icons.email),
                    trailing: Icon(Icons.edit)),
                ListTile(
                    title: Text("Address "),
                    subtitle: Text("113 street highway , New York , USA "),
                    leading: Icon(Icons.place),
                    isThreeLine: true,
                    trailing: Icon(Icons.edit)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
