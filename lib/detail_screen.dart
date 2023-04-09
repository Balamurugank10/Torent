import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int activeIndex = 0;

  final user = FirebaseAuth.instance.currentUser;

  // List<String> urlImages = [
  //   'https://media.istockphoto.com/id/1442689861/photo/old-fort-house-with-autumnal-trees-and-a-green-field-on-a-sunny-day.jpg?b=1&s=170667a&w=0&k=20&c=uMtOglJx-1QEh7MzG3Z2WaCXOD8bJKi6GEux5rZHe88=',
  //   'https://media.istockphoto.com/id/985417344/photo/emerging-residential-area.jpg?s=612x612&w=0&k=20&c=53BK584e1xFwr3ylx_WqQcVp7CbWmsaGxFZ8lqtSgbM=',
  //   'https://media.istockphoto.com/id/1442689861/photo/old-fort-house-with-autumnal-trees-and-a-green-field-on-a-sunny-day.jpg?b=1&s=170667a&w=0&k=20&c=uMtOglJx-1QEh7MzG3Z2WaCXOD8bJKi6GEux5rZHe88=',
  //   'https://media.istockphoto.com/id/985417344/photo/emerging-residential-area.jpg?s=612x612&w=0&k=20&c=53BK584e1xFwr3ylx_WqQcVp7CbWmsaGxFZ8lqtSgbM=',
  // ];

  // Stream<DocumentSnapshot<Map<String, dynamic>>> fetchList() async {
  //   const path = 'slide';
  //   return await Fire
  // }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments
        as String; //is the id to be passed in the arguments...

    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
              )),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("id", isEqualTo: productId)
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var loadedProducts = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                    return SingleChildScrollView(
                        child: Column(children: [
                      Stack(children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              // onPageChanged: (index, reason) {
                              //   setState(() {
                              //     activeIndex = index;
                              //   });
                              // },
                              viewportFraction: 1,
                              initialPage: 0,
                              autoPlayInterval: const Duration(seconds: 4),
                              height: 270,
                              enableInfiniteScroll: true,
                              autoPlay: true),
                          items: loadedProducts["multipleImages"]
                              .map<Widget>((e) => Container(
                                    child: Image(
                                      image: NetworkImage(e),
                                      fit: BoxFit.fill,
                                    ),
                                  ))
                              .toList(),
                          // itemCount: urlImages.length,
                          // itemBuilder: (context, index, realIndex) {
                          //   // final urlImage = urlImages[index];

                          //   return Container(
                          //       width: double.infinity,
                          //       color: Colors.grey,
                          //       child: Image(
                          //           image: NetworkImage(urlImages[index]),
                          //           fit: BoxFit.cover));
                          // },
                          // options: CarouselOptions(
                          //   initialPage: 0,
                          //   height: 270,
                          //   pauseAutoPlayOnTouch: true,
                          //   viewportFraction:
                          //       1, //at a time image to be displayed
                          //   autoPlay: true,
                          //   onPageChanged: (index, reason) {
                          //     setState(() {
                          //       activeIndex = index;
                          //       print('Index val1: ${index}');
                          //       print('active val1: ${activeIndex}');
                          //     });
                          //   },
                          //   //enableInfiniteScroll: true,
                          //   autoPlayInterval: Duration(seconds: 4),
                          // )
                        ),
                        // Positioned(
                        //     left: MediaQuery.of(context).size.width / 2.7,
                        //     bottom: 10,
                        //     child: Center(
                        //         child: AnimatedSmoothIndicator(
                        //       activeIndex: activeIndex,
                        //       count: loadedProducts["multipleImages"].length,
                        //       effect: const WormEffect(
                        //         activeDotColor: Colors.blue,
                        //       ),
                        //     )))
                      ]),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        child: Column(children: [
                          Row(
                            children: [
                              // Center(
                              //   child: Text(
                              //       '${List.from(loadedProducts["multipleImages"]).map((e) => "MultiOImage" + e)}'),
                              // ),
                              Text(
                                '₹${loadedProducts["rent"]}',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '/Month',
                                style: TextStyle(
                                  fontSize: 26,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  color: Colors.blue),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'No:${loadedProducts["flatno"]}, ${loadedProducts["street"]}, ${loadedProducts["area"]}, ${loadedProducts["city"]}',
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            const Text(
                              'Property type',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${loadedProducts["type"]}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ]),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.bed_outlined,
                                          color: Colors.orange,
                                          size: 35,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${loadedProducts["bedrooms"]}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 12),
                                      ],
                                    ),
                                    const Text(
                                      'Bedrooms',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ]),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.shower_outlined,
                                        color: Colors.deepOrange,
                                        size: 35,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${loadedProducts["bathrooms"]}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                  const Text(
                                    ' Bathrooms',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.car_repair_outlined,
                                            color: Colors.orange, size: 35),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${loadedProducts["parking"]}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 12),
                                      ],
                                    ),
                                    const Text(
                                      'Garage',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ]),
                              const SizedBox(width: 57),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.square_foot_outlined,
                                        color: Colors.green,
                                        size: 35,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${loadedProducts["sqft"]}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                  const Text(
                                    'Sq.feet',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      '${loadedProducts["description"]}',
                                      style: const TextStyle(fontSize: 18),
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 15,
                                    ),
                                  ],
                                )
                              ]),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Row(children: const [
                                      Icon(Icons.calendar_month_outlined),
                                      SizedBox(width: 10),
                                      Text(
                                        '  Updated on February 23, 2023',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ])
                                  ]),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Location info',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Landmark',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            'Area',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            'City',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            'State',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            'Country',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            'Pincode',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${loadedProducts["landmark"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '${loadedProducts["area"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '${loadedProducts["city"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '${loadedProducts["state"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '${loadedProducts["country"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '${loadedProducts["pincode"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                          ])
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              )),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Contact',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Owner Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            'Mobile No',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            'E-mail',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(height: 7),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${loadedProducts["name"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '+91 ${loadedProducts["mobile"]}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '${user?.email}',
                                              //'${loadedProducts["email"]}',
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 7),
                                          ])
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    final Uri callUrl = Uri(
                                        scheme: 'tel',
                                        path: '${loadedProducts["mobile"]}');
                                    if (await canLaunchUrl(callUrl)) {
                                      await launchUrl(callUrl);
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.call_outlined, size: 24.0),
                                      SizedBox(width: 5),
                                      Text('Call'),
                                    ],
                                  )),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                  onPressed: () async {
                                    final Uri callUrl = Uri(
                                        scheme: 'sms',
                                        path: '${loadedProducts["mobile"]}');
                                    if (await canLaunchUrl(callUrl)) {
                                      await launchUrl(callUrl);
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.message_outlined, size: 24.0),
                                      SizedBox(width: 5),
                                      Text('Message'),
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ]),
                      ),
                    ]));
                  });
        },
      ),
    );
  }
}
