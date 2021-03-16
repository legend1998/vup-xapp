import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vup/CategorySearch.dart';
import 'package:vup/model/Category.dart';
import 'package:vup/model/Services.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future catlist;

  List<Color> colors = [
    Colors.amber,
    Colors.amberAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.teal,
    Colors.green,
    Colors.red,
    Colors.pink,
    Colors.lime,
    Colors.purple,
    Colors.blue,
  ];

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
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: catlist,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  List data = snapshot.data;
                  if (data != null) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          Category cat = data[index];
                          return Card(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: colors[index % colors.length]),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategorySearch(
                                                  category: cat.category,
                                                )));
                                  },
                                  child: Center(
                                    child: Text(
                                      cat.category,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 1,
                        ),
                      ),
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
      ),
    );
  }
}
