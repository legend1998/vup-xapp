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
    catlist = Services.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: catlist,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                List data = snapshot.data;
                if (data != null) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Category cat = data[index];
                      return ListTile(
                        title: Text(cat.category),
                      );
                    },
                  );
                }
                return Center(
                  child: Text(data.toString()),
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
              {
                return Text("default");
              }
          }
        },
      ),
    );
  }
}
