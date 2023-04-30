import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_rent/screens/main_screen.dart';
import '../reusable_widgets/reusable_widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ignore: prefer_typing_uninitialized_variables
  var uname;
  // ignore: prefer_typing_uninitialized_variables
  var emailId;
  // ignore: prefer_typing_uninitialized_variables
  var mobileNo;
  final userName = FirebaseAuth.instance.currentUser!.displayName;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final userDp = FirebaseAuth.instance.currentUser!.photoURL;
  var imgUrl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Profile')),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('profiles')
                .where("emailId", isEqualTo: userEmail)
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
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                // physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    logoWidget("assets/images/logo.png"),
                                    // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                    // ProfileWidget(
                                    //     imagePath: imgUrl,
                                    //     onClicked: () async {}),
                                    Column(
                                      children: [
                                        TextField(
                                          onChanged: (value) {
                                            uname = value;
                                          },
                                          controller: TextEditingController(
                                              text: '${data["uname"]}'),
                                          decoration: const InputDecoration(
                                              labelText: "Full Name",
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ),
                                        const SizedBox(height: 15),
                                        TextField(
                                          readOnly: true,
                                          controller: TextEditingController(
                                              text: '${data["emailId"]}'),
                                          decoration: const InputDecoration(
                                              labelText: "E-mail",
                                              //hintText: "$userEmail",
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ),
                                        const SizedBox(height: 15),
                                        TextField(
                                          keyboardType: TextInputType.phone,
                                          onChanged: (value) {
                                            mobileNo = value;
                                          },
                                          controller: TextEditingController(
                                              text: '${data["mobileNo"]}'),
                                          decoration: const InputDecoration(
                                              labelText: "Mobile No",
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ),
                                        const SizedBox(height: 35),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MainScreen()));
                                                },
                                                child: const Text(
                                                  'CANCEL',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      letterSpacing: 2.2,
                                                      color: Colors.black),
                                                )),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('profiles')
                                                      .doc(data["id"])
                                                      .update({
                                                    'uname': uname,
                                                    'mobileNo': mobileNo
                                                  });
                                                },
                                                child: const Text(
                                                  'SAVE',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: 2.2,
                                                      fontSize: 14),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      });
            })));
  }
}
