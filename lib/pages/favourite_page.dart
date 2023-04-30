import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("isfavorite", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("detail", arguments: data["id"]);
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                                    data["multipleImages"][0],
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    color: Colors.green,
                                    child: Text(
                                      "₹${data['type']}",
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    color: Colors.black54,
                                    child: Text(
                                      "₹${data['rent']}",
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
                                    color: Colors.black54,
                                    child: IconButton(
                                      icon: Icon(
                                        data["isfavorite"]
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        data["isfavorite"]
                                            ? FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(data["id"])
                                                .update({'isfavorite': false})
                                            : FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(data["id"])
                                                .update({'isfavorite': true});
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(children: [
                                Text(
                                  "${data['area']} , ${data['city']}",
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.black38),
                                )
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
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
                                        "${data['bedrooms']}",
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
                                        "${data['bathrooms']}",
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
                                        "${data['parking']}",
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
                                        "${data['sqft']}",
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
                  });
        });
  }
}
