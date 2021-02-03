import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vup/model/Category.dart';
import 'package:vup/model/Services.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future catlist;

  @override
  void initState() {
    super.initState();
    setState(() {
      catlist = Services.getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
        future: catlist,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                var data = snapshot.data;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Category temp = data[index];
                    return ListTile(title: Text(temp.category));
                  },
                );
              }
            case ConnectionState.waiting:
              {
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
              }
            default:
              {
                return Text("default");
              }
          }
        },
      ),
    ));
  }
}
