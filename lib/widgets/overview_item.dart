//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_rent/detail_screen.dart';
import 'package:to_rent/providers/category_outline.dart';

class OverviewItem extends StatelessWidget {
  const OverviewItem({super.key});

  //const OverviewItem({super.key});

  // final String id;

  // final String imageUrl;

  // final String address;
  // final int amount;
  // final double bedRooms;
  // final double bathRooms;
  // final double sqft;
  // final double garage;
  // final String type;

  // final bool isFavorite;

  // const OverviewItem(
  //     this.id,
  //     this.address,
  //     this.amount,
  //     this.bathRooms,
  //     this.bedRooms,
  //     this.garage,
  //     this.imageUrl,
  //     this.isFavorite,
  //     this.sqft,
  //     this.type,
  //     {super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<CategoryOutline>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailScreen.routeName, arguments: product.id);
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Colors.green,
                    //width: 220,
                    child: Text(
                      product.type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    color: Colors.black54,
                    //width: 220,
                    child: Text(
                      '₹${product.amount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    color: Colors.black54,
                    //width: 220,
                    child: IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        product.toggleFavoriteStatus();
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(children: [
                Text(
                  product.city,
                  style: const TextStyle(fontSize: 24, color: Colors.black38),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bed_outlined,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.bedRooms}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.shower_outlined,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.bathRooms}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.car_repair_rounded,
                        color: Colors.orangeAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.garage}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.square_foot_outlined,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.sqft}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                    ],
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
