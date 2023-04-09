import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteProp extends StatefulWidget {
  const DeleteProp({super.key});

  @override
  State<DeleteProp> createState() => _DeletePropState();
}

class _DeletePropState extends State<DeleteProp> {
  final userAuth = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Properties'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                )),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where("email", isEqualTo: userAuth)
              .snapshots(),
          builder: ((context, snapshot) {
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
                                      //width: 220,
                                      child: Text(
                                        '${data["type"]}',
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
                                      //width: 220,
                                      child: Text(
                                        "₹${data['rent']}",
                                        // data['rent'],
                                        //  '₹${product.amount}',
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
                                    top: 20,
                                    right: 10,
                                    child: Container(
                                      //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                      color: Colors.black54,
                                      //width: 220,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                        ),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(data["id"])
                                              .delete();
                                        },
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

                                    //product.city,
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
                                          //'${product.bedRooms}',
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
                                          //'${product.bathRooms}',
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
                                          //'${product.garage}',
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
                                          //'${product.sqft}',
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
          }),
        ));
  }
}
