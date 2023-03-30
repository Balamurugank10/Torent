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

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments
        as String; //is the id to be passed in the arguments...
    final loadedProducts =
        Provider.of<Categories>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('house'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share_outlined,
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Stack(children: [
          CarouselSlider.builder(
              itemCount: loadedProducts.imglist.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = loadedProducts.imglist[index];

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
                  autoPlayInterval: const Duration(seconds: 4))),
          Positioned(
              left: MediaQuery.of(context).size.width / 2.7,
              bottom: 10,
              child: Center(
                  child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: loadedProducts.imglist.length,
                effect: const WormEffect(
                  activeDotColor: Colors.blue,
                ),
              )))
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Column(children: [
            Row(
              children: [
                Text(
                  '₹${loadedProducts.amount}',
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
                const Icon(Icons.location_pin, color: Colors.blue),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'No:${loadedProducts.houseNo}, ${loadedProducts.street}, ${loadedProducts.area}, ${loadedProducts.city}',
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
                loadedProducts.type,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bed_outlined,
                        color: Colors.orange,
                        size: 35,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${loadedProducts.bedRooms}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                          '${loadedProducts.bathRooms}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      const Icon(Icons.car_repair_outlined,
                          color: Colors.orange, size: 35),
                      const SizedBox(width: 4),
                      Text(
                        '${loadedProducts.garage}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                          '${loadedProducts.sqft}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
            Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    loadedProducts.description,
                    style: const TextStyle(fontSize: 18),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 15,
                  ),
                ]),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(children: const [
                    Icon(Icons.calendar_month_outlined),
                    SizedBox(width: 10),
                    Text(
                      'Updated on February 23, 2023',
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
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
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loadedProducts.landmark,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                loadedProducts.area,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                loadedProducts.city,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                loadedProducts.state,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                loadedProducts.country,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '${loadedProducts.pincode}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                            ])
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                )),
            ElevatedButton(onPressed: () {}, child: const Text('Show on Map')),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
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
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loadedProducts.ownerName,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '+91 ${loadedProducts.mobile}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                loadedProducts.email,
                                style: const TextStyle(fontSize: 17),
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
                      final Uri callUrl =
                          Uri(scheme: 'tel', path: "${loadedProducts.mobile}");
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
                      final Uri callUrl =
                          Uri(scheme: 'sms', path: "${loadedProducts.mobile}");
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
      ])),
    );
  }
}
