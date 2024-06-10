import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:subzero/screens/user/legal/legal_checkout.dart';
import 'package:subzero/utils/functions/functions.dart';

import '../../../provider/package_provider.dart';
import '../../../utils/constants/button_constant.dart';

class LegalPayment extends StatefulWidget {
  @override
  _LegalPaymentState createState() => _LegalPaymentState();
}

class _LegalPaymentState extends State<LegalPayment> {
  int _currentIndex = 0;

  final List<Map<String, String>> packages = [
    {
      'title': 'Contract Negotiation and Review',
      'price': 'Price TBD',
      'details':
          'This service provides professional assistance in negotiating and reviewing contracts with sponsors, teams, and tournament organizers. Legal experts ensure that all terms and conditions are fair and beneficial for the gamer, protecting their interests and preventing potential disputes.',
    },
    {
      'title': 'Legal Representation',
      'price': 'Price TBD',
      'details':
          'Gamers can access legal representation for any disputes or issues arising from contracts, sponsorships, and tournament participation. This service aims to resolve conflicts efficiently and ensure that the gamer’s rights are upheld.'
    },
    {
      'title': 'Trademark and Branding',
      'price': 'Price TBD',
      'details':
          'Assistance with trademark registration and protection is offered to safeguard the gamer’s identity and brand. Legal experts help gamers navigate the complexities of trademark law, ensuring their brand is legally protected and can be leveraged for further opportunities.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 10, left: 10),
        child: CustomActionButton(
            textStyle: TextStyle(color: Colors.white),
            text: 'Continue',
            onPressed: () {
              final selectedPackage = packages[_currentIndex];
              Provider.of<PackageState>(context, listen: false).selectPackage(
                selectedPackage['title']!,
                selectedPackage['price']!,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LegalCheckoutScreen()),
              );
            }, // Disable button if no package is selected
            height: 0.06,
            backColor: Colors.black // Change button color based on selection
            ),
      ),
      appBar: AppBar(
        title: Text('Select a Package'),
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: packages.length,
            itemBuilder: (context, index, realIndex) {
              final package = packages[index];
              return buildPackageCard(package, index == _currentIndex);
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.45,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Text('Swipe right for other packages >>>'),
        ],
      ),
    );
  }

  Widget buildPackageCard(Map<String, String> package, bool isSelected) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isSelected
            ? BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              package['title']!,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  package['price']!,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              package['details']!,
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
