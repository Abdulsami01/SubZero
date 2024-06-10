import 'package:flutter/material.dart';
import 'package:subzero/screens/user/coaching/choaching_services.dart';
import 'package:subzero/screens/user/drawer/drawer.dart';
import 'package:subzero/screens/user/legal/legal_services.dart';
import 'package:subzero/utils/functions/functions.dart';

import '../profile/profile.dart';
import '../sponsorship/sponsor_services.dart';

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, Functions.createFadeRoute(UserProfileScreen()));
              },
              child: Icon(Icons.person),
            ),
          ),
        ],
        title: Text('SubZero'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ServiceCard(
              onTap: () => Navigator.push(
                  context, Functions.createFadeRoute(CoachingServices())),
              title: 'Coaching',
              description:
                  'Pick your favorite genres, Find your coach and get ready to win tournament.',
              imagePath: 'assets/vectors/coaching.png',
            ),
            ServiceCard(
              onTap: () => Navigator.push(
                  context, Functions.createFadeRoute(LegalServices())),
              title: 'Legal and registration',
              description: 'Which tournament would you like to win ?',
              imagePath: 'assets/vectors/legal.png',
            ),
            ServiceCard(
              onTap: () => Navigator.push(
                  context, Functions.createFadeRoute(SponsorshipServices())),
              title: 'Sponsership',
              description:
                  'We will Manage your PR things! Social media Management,your  Press resales Companies to sponsership you!',
              imagePath: 'assets/vectors/sponsorship.png',
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final String imagePath;

  ServiceCard({
    required this.title,
    required this.onTap,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Image.asset(
                imagePath,
                width: 120,
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
