import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vup/Basket.dart';
import 'package:vup/Categories.dart';
import 'package:vup/LoginScreen.dart';
import 'package:vup/Orders.dart';
import 'package:vup/Profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vup/Splashscreen.dart';
import 'package:vup/about.dart';
import 'package:vup/model/Category.dart';
import 'package:vup/model/ProductLite.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';
import 'package:vup/model/cacheHive.dart';
import 'package:vup/utils/productTile.dart';
import 'package:vup/wishlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory dir = await getExternalStorageDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductLiteAdapter());
  Hive.registerAdapter(UserAdapter());
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
        fontFamily: "Open-Sans",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
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
  Future _bannerMidUrls;
  Future _bannerBotUrls;

  Future user;

  @override
  void initState() {
    super.initState();
    _bannerTopUrls = Services.getTopBannerUrls();
    // _bannerMidUrls = Services.getTopBannerUrls();
    // _bannerBotUrls = Services.getTopBannerUrls();
    user = Services.getUser();
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
            padding: EdgeInsets.only(right: 10),
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
            child: FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    User userData = snapshot.data;
                    return ListView(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  'https://ui-avatars.com/api/?name=${userData.fname}+${userData.lname}&size=128'),
                              backgroundColor: Colors.blue,
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            userData.fname,
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                        ),
                        Text(
                          userData.email,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.black45),
                        )
                      ],
                    );
                  default:
                    return Text("something went wrong");
                }
              },
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
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () async {
              HiveService hiveService = new HiveService();
              await hiveService.deleteBox("user");
              if (await hiveService.isExists(boxName: "user")) {
                Fluttertoast.showToast(
                    msg: "something went wrong can't log out.");
              } else {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
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
      padding: EdgeInsets.all(5),
      height: 1750,
      child: FutureBuilder(
          future: Services.getlatestproducts(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  var data = snapshot.data;
                  return GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(data.length, (index) {
                      return productTile(data[index], context);
                    }),
                  );
                }
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
                return Text("something went wrong");
            }
          }),
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
    child: FutureBuilder(
      future: Services.getCategory(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              var data = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Category cat = data[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(width: 1, color: Colors.blue)),
                    child: Text(cat.category),
                  );
                },
              );
            }
          case ConnectionState.waiting:
            return Container(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white24,
                child: Container(
                  height: 50,
                  color: Colors.white54,
                ),
              ),
              alignment: Alignment.center,
            );
          default:
            return Text("something went wrong");
        }
      },
    ));

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

  List<String> recentList = [];

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (!recentList.contains(query) && query != "" && query != " ") {
      recentList.add(query);
    }
    return Container(
        child: FutureBuilder(
      future: Services.searchResult(query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            var data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return productSearchTile(data[index], context);
                });
          //to be worked here
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Center(
              child: Text("something went wrong"),
            );
        }
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> suggestionList = [];
    suggestionList = recentList;

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(suggestionList[index]));
      },
    );
  }
}
