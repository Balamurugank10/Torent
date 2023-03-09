import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/categories.dart';
import './overview_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Categories>(context);
    final products = productsData.items;

    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: const OverviewItem(
                  // products[i].id,
                  // products[i].address,
                  // products[i].amount,
                  // products[i].bathRooms,
                  // products[i].bedRooms,
                  // products[i].garage,
                  // products[i].imageUrl,
                  // products[i].isFavorite,
                  // products[i].sqft,
                  // products[i].type
                  ),
            ));
  }
}
