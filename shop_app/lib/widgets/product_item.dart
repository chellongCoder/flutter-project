import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(
      {Key? key, required this.id, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ProductDetailScreen(title: title),
            ),
          );
        },
        child: GridTile(
          child: Image.network(imageUrl, fit: BoxFit.cover),
          footer: GridTileBar(
            leading: Icon(Icons.favorite, color: Theme.of(context).accentColor),
            backgroundColor: Colors.black54,
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing:
                Icon(Icons.shopping_cart, color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
