import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:subzero/utils/functions/functions.dart';

import '../../../provider/package_provider.dart';
import '../../../utils/constants/button_constant.dart';
import 'coaching_checkout.dart';

class CoachingPaymentScreen extends StatefulWidget {
  @override
  _CoachingPaymentScreenState createState() => _CoachingPaymentScreenState();
}

class _CoachingPaymentScreenState extends State<CoachingPaymentScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> packages = [
    {
      'title': 'Hourly Coaching Package',
      'subtitle':
          'One-on-one coaching by the hour with a certified coach chosen by the gamer.',
      'price': 'SAR 2,499',
      'details':
          'This package offers one-on-one coaching sessions charged by the hour. Gamers can select a certified coach from a comprehensive list based on their game of choice and specific coaching needs. Ideal for players looking to improve specific aspects of their gameplay, these sessions focus on personalized feedback, in-game strategies, and skill refinement. The flexible nature of this package allows gamers to book sessions as needed, making it suitable for both casual and competitive players.'
    },
    {
      'title': 'Semi-Professional/Professional Package',
      'subtitle':
          'Intensive personalized coaching for gamers aiming to participate in tournaments.',
      'price': 'SAR 3,299',
      'details':
          'Designed for gamers who aspire to compete in tournaments, this package includes extensive hours of personalized coaching. Coaches provide in-depth gameplay analysis, strategic planning, and mechanical skill training. Additional support includes mental conditioning to handle competitive pressures and improve performance consistency. This package ensures that gamers are tournament-ready, covering all aspects from game mechanics to psychological resilience.'
    },
    {
      'title': 'Team Coaching Package',
      'subtitle':
          'Coaching for entire teams to enhance team coordination and performance.',
      'price': 'SAR 7,899',
      'details':
          'This package focuses on enhancing the performance of entire teams. Sessions cover teamwork drills, strategy formulation, and role-specific coaching to improve coordination and communication within the team. Coaches work with the team to develop and implement game strategies, optimize in-game roles, and build synergy. This package is perfect for teams preparing for tournaments, aiming to elevate their collective gameplay and achieve better results in competitions.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
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
                MaterialPageRoute(
                    builder: (context) => CoachingCheckoutScreen()),
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
              height: MediaQuery.of(context).size.height * 0.55,
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
            Text(
              package['subtitle']!,
              style: TextStyle(fontSize: 16, color: Colors.black54),
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
