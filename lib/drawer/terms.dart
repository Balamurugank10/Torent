import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingTerms('Account'),
                explanationTerms(
                    'Any people can create an account in the ToRent App. All account should be real. If anyone creates a fake account and ToRent app verify that as a fake then the account will be permanent disable in the ToRent application. So ensure that all account information is real.'),
                sizedHeight(),
                headingTerms('Account Image'),
                explanationTerms(
                    'Automatically add their image to their profile through your e-mail.'),
                sizedHeight(),
                headingTerms('Email'),
                explanationTerms(
                    'Users are reequired to submit a valid email address before they are allowed to post properties.'),
                sizedHeight(),
                headingTerms('Mobile number'),
                explanationTerms(
                    'The phone number is the most important information for property. The user should give a phone number at the posting the properties. If anyone gives fake number and the ToRent application verify the number as a fake then the post can be blocked.'),
                sizedHeight(),
                headingTerms('Location'),
                explanationTerms(
                    'While posting the properties, the owner should use a real location by clicking a dropdown menu like the flatNo, street, area, city, state. you should use correct location address of your property.'),
                sizedHeight(),
                headingTerms('Basic Imformation'),
                explanationTerms(
                    "First, choose the date when your house will ready for rent. Then also use real information in other steps. Set a monthly rent of your property. Don/'t give wrong information."),
                sizedHeight(),
                headingTerms('Images'),
                explanationTerms(
                    'Try to use clear images for upload. Image of your property is mandatory.'),
                sizedHeight(),
                headingTerms('Contact Details'),
                explanationTerms(
                    'Contact details is the most necessary part for publish your property. You should give original information in this section.'),
                sizedHeight(),
                headingTerms('Cookies'),
                explanationTerms('hhhhhhhhhhhhhhhhhhh')
              ],
            )),
      ),
    );
  }

  Widget headingTerms(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    );
  }

  Widget explanationTerms(String text) {
    return Text(
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: 10,
      '       $text',
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }

  Widget sizedHeight() {
    return const SizedBox(height: 20);
  }
}
