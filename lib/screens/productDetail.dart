import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() => ProductDetailState(product);
}

////*********
//db helper
DbHelper dbHelper = DbHelper();

// enum writing
enum Choice { Delete, Update }
// pop up için açtık !
/// *********

class ProductDetailState extends State {
  Product product;
  ProductDetailState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail For {$product.name}"),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected:select, //aşağıda operasyonunu yazdık zaten ! 
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
              PopupMenuItem<Choice>(
                value: Choice.Delete,
                child: Text("Delete product"),
              ),
              PopupMenuItem<Choice>(
                value: Choice.Update,
                child: Text("Update product"),
              ),
            ],
          ) //pop up menu girişi genric türü choice ve array [] choice için bir array
        ],
      ),
      body: Center(
        child: Card(
            child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.shop),
              title: Text(product.name),
              subtitle: Text(product.description),
            ),
            Text("${product.name} price is: ${product.price}"),
            ButtonTheme(
              child: ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: Text("add to Card"),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void select(Choice choice) async {
    int result;
    switch (choice) {
      case Choice.Delete:
        Navigator.pop(context); // bir oncekı geldiği yere gönderiyoruz
        result = await dbHelper.delete(product.id);
        if (result != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Success"),
            content: Text("Deleted product : ${product.name}"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      default:
    }
  }
}
