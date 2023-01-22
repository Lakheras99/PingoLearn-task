import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pingolearn/productModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductFeed();
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProductFeed(),
//     );
//   }
// }
class ProductFeed extends StatefulWidget {
  @override
  _ProductFeedState createState() => _ProductFeedState();
}

class _ProductFeedState extends State<ProductFeed> {
  late ProductModel _productModel;
  List<Products> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Feed'),
        ),
        body: GridView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ));
  }

  Future<void> fetchProducts() async {
    var url = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _productModel = ProductModel.fromJson(data);
      for (int i = 0; i < _productModel.products!.length; i++) {
        products.add(_productModel.products![i]);
      }
    } else {
      print('Error retrieving products from the API');
    }
    setState(() {});
  }
}

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  String discountedPrice(ogPrice, discount) {
    var finalPrice = double.parse("$ogPrice") -
        ((double.parse("$ogPrice") * discount) / 100);
    return "${finalPrice.roundToDouble()}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Image.network(product.images![0]))),
            SizedBox(
              height: 10,
            ),
            Text(
              product.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(product.description!,
                maxLines: 3, overflow: TextOverflow.ellipsis),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
                Text(discountedPrice(
                    product.price, product.discountPercentage!)),
                Text(
                  '${product.discountPercentage!}% off',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
