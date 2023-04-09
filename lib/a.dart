import 'package:flutter/material.dart';
import './user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './detail_screen.dart';

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  String city = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'search your city'),
            onChanged: ((value) {
              setState(() {
                city = value;
              });
            }),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
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

                      if (city.isEmpty) {
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
                                                    .update(
                                                        {'isfavorite': false})
                                                : FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(data["id"])
                                                    .update(
                                                        {'isfavorite': true});
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                      if (data['city']
                          .toString()
                          .toLowerCase()
                          .startsWith(city.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("detail", arguments: data["id"]);
                            // Navigator.of(context).pushNamed(
                            //     DetailScreen.routeName,
                            //     arguments: data['id']);
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
                                          data['type'],
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
                                                    .update(
                                                        {'isfavorite': false})
                                                : FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(data["id"])
                                                    .update(
                                                        {'isfavorite': true});
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                                            style:
                                                const TextStyle(fontSize: 15),
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
                                            style:
                                                const TextStyle(fontSize: 15),
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

                      return Container();
                    });
          }),
    );
  }

  Widget buildUser(Userdb user) => InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailScreen.routeName, arguments: user.id);
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
                    'https://media.istockphoto.com/id/1442689861/photo/old-fort-house-with-autumnal-trees-and-a-green-field-on-a-sunny-day.jpg?b=1&s=170667a&w=0&k=20&c=uMtOglJx-1QEh7MzG3Z2WaCXOD8bJKi6GEux5rZHe88=',
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
                      user.propType,
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
                      '₹${user.rent}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 20,
                //   right: 10,
                //   child: Container(
                //     //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                //     color: Colors.black54,
                //     //width: 220,
                //     // child: IconButton(
                //     //   icon: Icon(

                //     //     //product.isFavorite ? Icons.favorite : Icons.favorite_border,
                //     //     color: Colors.white,
                //     //   ),
                //     //   onPressed: () {
                //     //     product.toggleFavoriteStatus();
                //     //   },
                //     ),
                //   ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(children: [
                Text(
                  user.city,
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
                        '${user.bedrooms}',
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
                        '${user.bathrooms}',
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
                        '${user.parking}',
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
                        '${user.sqft}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                    ],
                  )
                ],
              ),
            ),
          ])));

  // Widget buildUser(User user) =>
  //    Text('${user.bedrooms.toInt()} ${user.availableDate}');

  Stream<List<Userdb>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Userdb.fromJson(doc.data())).toList());
}
