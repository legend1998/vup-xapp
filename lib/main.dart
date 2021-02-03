import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vup/Basket.dart';
import 'package:vup/Categories.dart';
import 'package:vup/LoginScreen.dart';
import 'package:vup/Orders.dart';
import 'package:vup/Profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vup/about.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/wishlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  List<String> get list => null;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future _bannerTopUrls;

  @override
  void initState() {
    super.initState();
    _bannerTopUrls = Services.getTopBannerUrls();
  }

  @override
  Widget build(BuildContext context) {
    var _scaffodKey = GlobalKey<ScaffoldState>();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffodKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffodKey.currentState.openDrawer();
          },
        ),

        title: Text(widget.title),

        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // open searh area
              showSearch(context: context, delegate: Search(widget.list));
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () {
                //open basket
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Basket()));
              },
            ),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: ListView(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue,
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "profile name",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
                Text(
                  "profile  email",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                )
              ],
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
          Divider(color: Colors.blue),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          ListTile(
              leading: Icon(Icons.category),
              title: Text("Categories"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryScreen()));
              }),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Wishlist"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Wishlist()));
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text("Orders"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Orders()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_rounded),
            title: Text("About"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Faqs"),
          ),
        ],
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
                future: _bannerTopUrls,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return CarouselSlider.builder(
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var image = snapshot.data[index];
                          return Image.network(image);
                        },
                      );
                    case ConnectionState.waiting:
                      return Container(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.white24,
                          child: Container(
                            height: 150,
                            color: Colors.white54,
                          ),
                        ),
                        alignment: Alignment.center,
                      );
                    default:
                      return Text("default");
                  }
                }),
            Divider(
              color: Colors.grey[500],
              endIndent: 10.0,
              indent: 10.0,
            ),
            categories(),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "new Arrivals",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 22,
                    fontFamily: "roboto"),
              ),
            ),
            newArrivals(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Featured ",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 22,
                    fontFamily: "roboto"),
              ),
            ),
            featured(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Trending now ",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 22,
                    fontFamily: "roboto"),
              ),
            ),
            trendingNow(),
          ],
        ),
      ),
    );
  }
}

Widget newArrivals() => Container(
      height: 200,
    );
Widget trendingNow() => Container(
      height: 200,
    );
Widget featured() => Container(
      height: 200,
    );

// categories on home  page

Widget categories() => Container(
      alignment: Alignment.center,
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("tops"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("saree"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("T-shirts"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Pyjama"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Jeans"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Shirts"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Trending"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Winter Wear"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Casual"),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Brands"),
          ),
        ],
      ),
    );

class Search extends SearchDelegate {
  final List<String> listofproducts;

  Search(this.listofproducts);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedtext;

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(child: Center(child: Text(selectedtext)));
  }

  List<String> recentList = ["text 4", "text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> suggestionList = [];
//    query.isEmpty
    //      ? suggestionList = recentList
    //    : suggestionList
    //      .addAll(listofproducts.where((element) => element.contains(query)));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(suggestionList[index]));
      },
    );
  }
}
