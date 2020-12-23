import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/Basket.dart';
import 'package:vup/LoginScreen.dart';
import 'package:vup/Product.dart';
import 'package:vup/Profile.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vup',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
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
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Wishlist"),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text("Orders"),
          ),
          ListTile(
            leading: Icon(Icons.info_rounded),
            title: Text("About"),
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
            Container(
              child: CarouselSlider(
                options: CarouselOptions(height: 140.0, autoPlay: true),
                items: [1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: Image.asset('images/banner$i.jpg'));
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Top selling products",
                style: TextStyle(fontSize: 22, color: Colors.grey[600]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 22),
              height: 150,
              child: ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.grey[300])),
                          child: Column(
                            children: [
                              new Image.network(
                                  'https://source.unsplash.com/120x120/?cloth,fashion,$index'),
                              Text('product ${index + 1}')
                            ],
                          )),
                      onTap: () {
                        // go to product page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductScreen()));
                      },
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Today's Trendig",
                style: TextStyle(fontSize: 22, color: Colors.grey[600]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 22),
              alignment: Alignment.center,
              height: 700,
              child: ListView.builder(
                  itemCount: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey[300])),
                        child: Row(
                          children: [
                            new Image.network(
                                'https://source.unsplash.com/120x120/?cloth,fashion,$index'),
                            SizedBox(
                              width: 20,
                            ),
                            Text('product ${index + 1}'),
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

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
