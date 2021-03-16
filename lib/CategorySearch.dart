import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/model/ProductLite.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/utils/productTile.dart';

class CategorySearch extends StatefulWidget {
  CategorySearch({Key key, this.category}) : super(key: key);

  final String category;

  @override
  _CategorySearchState createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  bool loading = false;
  List<ProductLite> p;

  @override
  void initState() {
    super.initState();
    loadcatproduct();
  }

  void loadcatproduct() async {
    List<ProductLite> temp =
        await Services.getproductbyCategory(widget.category);
    setState(() {
      p = temp;
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              loading
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: p.isEmpty
                          ? Center(
                              child: Text("coming soon..."),
                            )
                          : ListView.builder(
                              itemCount: p.length,
                              itemBuilder: (context, index) {
                                return productSearchTile(p[index], context);
                              },
                            ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
            ],
          ),
        ));
  }
}
