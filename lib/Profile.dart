import 'package:flutter/material.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User person;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    loaddata();
  }

  loaddata() async {
    person = await Services.getUser();
    setState(() {
      loading = true;
    });
  }

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
                  backgroundImage: loading
                      ? NetworkImage(
                          'https://ui-avatars.com/api/?name=${person.fname}+${person.lname}&size=256&rounded=true')
                      : NetworkImage(
                          "https://ui-avatars.com/api/?name=john+doe&size=256&rounded=true"),
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
                    subtitle: loading
                        ? Text('${person.fname} ${person.lname}')
                        : Text("john doe "),
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.edit)),
                ListTile(
                    title: Text("Mobile Number"),
                    subtitle: loading ? Text(person.phone) : Text("9999999999"),
                    leading: Icon(Icons.mobile_friendly),
                    trailing: Icon(Icons.edit)),
                ListTile(
                    title: Text("E-mail"),
                    subtitle: loading
                        ? Text(person.email)
                        : Text("john.doe@gmail.com"),
                    leading: Icon(Icons.email),
                    trailing: Icon(Icons.edit)),
                ListTile(
                    title: Text("Address "),
                    subtitle: loading
                        ? Text('${person.address.toString()}')
                        : Text("113 street highway , New York , USA "),
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
