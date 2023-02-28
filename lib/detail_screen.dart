import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/categories.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  static const routeName = '/detail-screen';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments
        as String; //is the id to be passed in the arguments...
    final loadedProducts =
        Provider.of<Categories>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.type),
      ),
    );
  }
}
