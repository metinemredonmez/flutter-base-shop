import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/productDetail.dart';
import 'package:flutter/material.dart';

class productAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State {
  // trxt editing controller
  TextEditingController txtname = new TextEditingController();
  TextEditingController txtdesc = new TextEditingController();
  TextEditingController txtprice = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    DbHelper dbHelper = new DbHelper();
    return Scaffold(
      appBar: AppBar(
        title: Text("add a new  product"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            TextField(
              controller: txtname,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: txtdesc,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: txtprice,
              decoration: InputDecoration(labelText: "Price"),
            ),
            TextButton(
              child: Text("save"),
              onPressed: () {
                save();
              },
            )
          ],
        ),
      ),
    );
  }

  void save() async {
    int result = await dbHelper.insert(
        Product(txtname.text, txtdesc.text, double.tryParse(txtprice.text)));

    if (result != 0) {
      Navigator.pop(context, true);
    }
  }
}
