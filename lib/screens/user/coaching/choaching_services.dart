import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/coaching_provider.dart';
import 'select_coaches.dart';
import '../../../utils/constants/button_constant.dart';
import '../../../utils/functions/functions.dart';

class CoachingServices extends StatefulWidget {
  @override
  _CoachingServices createState() => _CoachingServices();
}

class _CoachingServices extends State<CoachingServices> {
  String? selectedCoachingSession;
  String? selectedCoachingSessionImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 80, right: 10, left: 10),
        child: CustomActionButton(
          textStyle: TextStyle(color: Colors.white),
          text: 'Continue',
          onPressed: () {
            if (selectedCoachingSession == null) {
              Functions.showSnackBar(
                  context, 'Ohh No!', 'Please select any session', Colors.red);
            } else {
              Provider.of<CoachingState>(context, listen: false)
                  .selectCoachingSession(
                      selectedCoachingSession!, selectedCoachingSessionImage!);
              Navigator.push(
                  context, Functions.createFadeRoute(SelectCoaches()));
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
              'Coaching Sessions',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 65),
            Text(
              'Our coaching services provide personalized training for gamers of all levels. Whether you’re seeking one-on-one sessions, preparing for tournaments, or looking to enhance team performance, our certified coaches offer expert guidance on strategies, mechanics, and mental conditioning to help you achieve your gaming goals.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 65),
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCoachingSessionCard('First Person Shooter',
                      'assets/services/coaching/sessions/fps.png'),
                  buildCoachingSessionCard('Multiplayer Online Battle Arena',
                      'assets/services/coaching/sessions/moba.png'),
                  buildCoachingSessionCard('Role-Playing Game',
                      'assets/services/coaching/sessions/3rdcoach.png'),
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
    bool isSelected = selectedCoachingSession == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCoachingSession = title;
          selectedCoachingSessionImage = image;
        });
      },
      child: Container(
        width: 150,
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
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
