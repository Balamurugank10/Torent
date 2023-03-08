import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int activeIndex = 0;
  final urlImages = [
    'https://media.istockphoto.com/id/1442689861/photo/old-fort-house-with-autumnal-trees-and-a-green-field-on-a-sunny-day.jpg?b=1&s=170667a&w=0&k=20&c=uMtOglJx-1QEh7MzG3Z2WaCXOD8bJKi6GEux5rZHe88=',
    'https://media.istockphoto.com/id/985417344/photo/emerging-residential-area.jpg?s=612x612&w=0&k=20&c=53BK584e1xFwr3ylx_WqQcVp7CbWmsaGxFZ8lqtSgbM=',
    'https://media.istockphoto.com/id/1442689861/photo/old-fort-house-with-autumnal-trees-and-a-green-field-on-a-sunny-day.jpg?b=1&s=170667a&w=0&k=20&c=uMtOglJx-1QEh7MzG3Z2WaCXOD8bJKi6GEux5rZHe88=',
    'https://media.istockphoto.com/id/985417344/photo/emerging-residential-area.jpg?s=612x612&w=0&k=20&c=53BK584e1xFwr3ylx_WqQcVp7CbWmsaGxFZ8lqtSgbM=',
  ];

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments
        as String; //is the id to be passed in the arguments...
    final loadedProducts =
        Provider.of<Categories>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text('house'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share_outlined,
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        // width: double.infinity,
        child: Column(children: [
          Stack(children: [
            CarouselSlider.builder(
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];

                  return Container(
                      width: double.infinity,
                      //margin: EdgeInsets.all(10),
                      color: Colors.grey,
                      child: Image.network(urlImage, fit: BoxFit.cover));
                },
                options: CarouselOptions(
                    initialPage: 0,
                    height: 270,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 1, //at a time image to be displayed
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    //enableInfiniteScroll:
                    //   false, //last image can't mingle with the 1st image
                    autoPlayInterval: Duration(seconds: 4))),
            Positioned(
                left: MediaQuery.of(context).size.width / 2.7,
                bottom: 10,
                child: Center(
                    child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: urlImages.length,
                  effect: WormEffect(
                    activeDotColor: Colors.blue,
                  ),
                )))
          ]),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Column(children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      '₹${loadedProducts.amount}',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '/Month',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(
                      '${loadedProducts.city}',
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              Container(
                child: Row(children: [
                  Text(
                    'Property type',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${loadedProducts.type}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Container(
                  //height: 70,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bed_outlined,
                              color: Colors.orange,
                              size: 35,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${loadedProducts.bedRooms}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 12),
                          ],
                        ),
                        Text(
                          'Bedrooms',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ]),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shower_outlined,
                            color: Colors.deepOrange,
                            size: 35,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${loadedProducts.bathRooms}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                      Text(
                        ' Bathrooms',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ],
              )),
              SizedBox(height: 10),
              Container(
                  // height: 160,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.car_repair_outlined,
                                color: Colors.orange, size: 35),
                            SizedBox(width: 4),
                            Text(
                              '${loadedProducts.garage}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 12),
                          ],
                        ),
                        Text(
                          'Garage',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ]),
                  SizedBox(width: 57),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.square_foot_outlined,
                            color: Colors.green,
                            size: 35,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${loadedProducts.sqft}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                      Text(
                        'Sq.feet',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ],
              )),
              SizedBox(height: 10),
              Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${loadedProducts.description}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ]),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              Container(
                  child: Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(children: [
                          Icon(Icons.calendar_month_outlined),
                          SizedBox(width: 10),
                          Text(
                            'Updated on February 23, 2023',
                            style: TextStyle(fontSize: 18),
                          ),
                        ])
                      ]),
                ],
              )),
              SizedBox(height: 10),
              Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location info',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Landmark',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Area',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'City',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'State',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Country',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Pincode',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${loadedProducts.landmark}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '${loadedProducts.area}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '${loadedProducts.city}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '${loadedProducts.state}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '${loadedProducts.country}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '${loadedProducts.pincode}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                              ])
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              ElevatedButton(onPressed: () {}, child: Text('Show on Map')),
              SizedBox(height: 10),
              Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Owner Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Mobile No',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'E-mail',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(height: 7),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${loadedProducts.ownerName}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '+91 ${loadedProducts.mobile}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '${loadedProducts.email}',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(height: 7),
                              ])
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              ElevatedButton(onPressed: () {}, child: Text('Call')),
              SizedBox(height: 10),
            ]),
          ),
        ]),
      )),
    );
    //  Scaffold(
    //   appBar: AppBar(
    //     title: Text(loadedProducts.type),
    //   ),
    //   body: SingleChildScrollView(
    //       child: Column(children: [
    //     Container(
    //         height: 300,
    //         width: double.infinity,
    //         child: Image.network(
    //           loadedProducts.imageUrl,
    //           fit: BoxFit.cover,
    //         )),
    //     Column(children: [
    //       Container(
    //         child: Row(
    //           children: [
    //             Text(
    //               '₹${loadedProducts.amount}',
    //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //             ),
    //             Text(
    //               '/Month',
    //               style: TextStyle(
    //                 fontSize: 30,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       Container(
    //         child: Row(
    //           children: [
    //             Icon(Icons.location_pin),
    //             SizedBox(width: 5),
    //             Text(
    //               '${loadedProducts.address}',
    //               style: TextStyle(fontSize: 24),
    //             )
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       Divider(),
    //       Container(
    //         child: Row(children: [
    //           Text(
    //             'Property type',
    //             style: TextStyle(fontSize: 18),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             '${loadedProducts.type}',
    //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //           ),
    //         ]),
    //       ),
    //       SizedBox(height: 10),
    //       Container(
    //           //height: 70,
    //           child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //             Row(
    //               children: [
    //                 Icon(
    //                   Icons.bed_outlined,
    //                   color: Colors.orange,
    //                   size: 35,
    //                 ),
    //                 SizedBox(width: 4),
    //                 Text(
    //                   '${loadedProducts.bedRooms}',
    //                   style:
    //                       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //                 ),
    //                 SizedBox(width: 12),
    //               ],
    //             ),
    //             Text(
    //               'Bedrooms',
    //               style: TextStyle(
    //                 fontSize: 20,
    //               ),
    //             )
    //           ]),
    //           SizedBox(width: 30),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.shower_outlined,
    //                     color: Colors.deepOrange,
    //                     size: 35,
    //                   ),
    //                   SizedBox(width: 4),
    //                   Text(
    //                     '${loadedProducts.bathRooms}',
    //                     style: TextStyle(
    //                         fontSize: 20, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(width: 12),
    //                 ],
    //               ),
    //               Text(
    //                 ' Bathrooms',
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ],
    //       )),
    //       SizedBox(height: 10),
    //       Container(
    //           // height: 160,
    //           child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //             Row(
    //               children: [
    //                 Icon(Icons.car_repair_outlined,
    //                     color: Colors.orange, size: 35),
    //                 SizedBox(width: 4),
    //                 Text(
    //                   '${loadedProducts.garage}',
    //                   style:
    //                       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //                 ),
    //                 SizedBox(width: 12),
    //               ],
    //             ),
    //             Text(
    //               'Garage',
    //               style: TextStyle(
    //                 fontSize: 20,
    //               ),
    //             )
    //           ]),
    //           SizedBox(width: 57),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.square_foot_outlined,
    //                     color: Colors.green,
    //                     size: 35,
    //                   ),
    //                   SizedBox(width: 4),
    //                   Text(
    //                     '${loadedProducts.sqft}',
    //                     style: TextStyle(
    //                         fontSize: 20, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(width: 12),
    //                 ],
    //               ),
    //               Text(
    //                 'Sq.feet',
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ],
    //       )),
    //       Divider(),
    //       Container(
    //           child: Row(
    //         children: [
    //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //             Text(
    //               'Description',
    //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //             ),
    //             Text(
    //               'jdkhfuidhhhhhhhhg',
    //               style: TextStyle(fontSize: 18),
    //             ),
    //           ]),
    //         ],
    //       )),
    //       Divider(),
    //       Container(
    //           child: Row(
    //         children: [
    //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //             Text(
    //               'Details',
    //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //             ),
    //             Row(children: [
    //               Icon(Icons.calendar_month_outlined),
    //               SizedBox(width: 10),
    //               Text(
    //                 'Updated on February 23, 2023',
    //                 style: TextStyle(fontSize: 18),
    //               ),
    //             ])
    //           ]),
    //         ],
    //       )),
    //       Divider(),
    //     ]),
    //   ])),
    // );
  }
}
