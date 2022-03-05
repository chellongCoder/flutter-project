import 'package:flutter/material.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsOverview extends StatelessWidget {
  const ProductsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
      ),
      body: GridView.builder(
        itemCount: Products().items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ProductItem(
            id: Products().items[i].id,
            title: Products().items[i].title,
            imageUrl: Products().items[i].imageUrl),
      ),
    );
  }
}
