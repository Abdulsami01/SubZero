import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/coaching_provider.dart';
import '../../coaches/coaches.dart';
import 'coaching_checkout.dart';
import 'coaching_payment.dart';
import '../../../utils/constants/button_constant.dart';
import '../../../utils/functions/functions.dart';

class SelectCoaches extends StatefulWidget {
  @override
  _CoachingServices createState() => _CoachingServices();
}

class _CoachingServices extends State<SelectCoaches> {
  String? selectedGame;
  String? selectedGameImage;
  String? selectedCoach;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: CustomActionButton(
          textStyle: TextStyle(color: Colors.white),
          text: 'Continue',
          onPressed: () {
            if (selectedCoach == null || selectedGame == null) {
              Functions.showSnackBar(
                  context, 'Ohh No!', 'Please select game & coach', Colors.red);
            } else {
              Provider.of<CoachingState>(context, listen: false)
                  .selectGame(selectedGame!, selectedGameImage!);
              Provider.of<CoachingState>(context, listen: false)
                  .selectCoach(selectedCoach!);
              Navigator.push(
                  context, Functions.createFadeRoute(CoachingPaymentScreen()));
            }
          },
          height: 0.06,
          backColor: Colors.black,
        ),
      ),
      appBar: AppBar(
        title: Text('Coaching Sessions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Pick your Favorite Game',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Our coaching services provide Specialized training for the following games to take to the next level and get you ready to participate in the upcoming tournament.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCoachingSessionCard(
                    'League of Legends',
                    'assets/services/coaching/game/legends.png',
                  ),
                  buildCoachingSessionCard('Heroes of the Storm',
                      'assets/services/coaching/game/heroes.png'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Coaches available based on your choice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trusted Professional Coaches',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        Functions.createFadeRoute(CoachingProfilesScreen()));
                  },
                  child: Text(
                    'coaches profiles >>',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCoachCard(
                      'Ahmed', 'assets/services/coaching/coaches/ahmed.png'),
                  buildCoachCard(
                      'Wejdan', 'assets/services/coaching/coaches/wejdan.png'),
                  buildCoachCard('AI coach',
                      'assets/services/coaching/coaches/aicoach.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCoachingSessionCard(
    String title,
    String image,
  ) {
    bool isSelected = selectedGame == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGame = title;
          selectedGameImage = image;
        });
      },
      child: Container(
        width: 180,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected ? Colors.greenAccent : Colors.transparent,
                    width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  width: 180,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: AutoSizeText(
                      maxLines: 1,
                      minFontSize: 12,
                      maxFontSize: 14,
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCoachCard(String name, String image) {
    bool isSelected = selectedCoach == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCoach = name;
        });
      },
      child: Container(
        width: 80,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected ? Colors.greenAccent : Colors.transparent,
                    width: 2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: ClipOval(
                child: Image.asset(
                  image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(name),
          ],
        ),
      ),
    );
  }
}
