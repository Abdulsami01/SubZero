import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subzero/provider/legal_provider.dart';
import 'package:subzero/screens/user/legal/legal_payment.dart';
import '../../../provider/coaching_provider.dart';
import '../../../utils/constants/button_constant.dart';
import '../../../utils/functions/functions.dart';
import '../coaching/select_coaches.dart';

class LegalServices extends StatefulWidget {
  @override
  _CoachingServices createState() => _CoachingServices();
}

class _CoachingServices extends State<LegalServices> {
  String? selectedLegalSession;
  String? selectedLegalSessionImage;

  @override
  void initState() {
    super.initState();
    selectedLegalSession = 'World Cup 2024 registration';
    selectedLegalSessionImage = 'assets/services/legal/open.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 80, right: 10, left: 10),
        child: CustomActionButton(
          textStyle: TextStyle(color: Colors.white),
          text: 'Continue',
          onPressed: () {
            if (selectedLegalSession == null) {
              Functions.showSnackBar(
                  context, 'Ohh No!', 'Please select any session', Colors.red);
            } else {
              Provider.of<LegalState>(context, listen: false)
                  .selectLegalSession(
                      selectedLegalSession!, selectedLegalSessionImage!);
              Navigator.push(
                  context, Functions.createFadeRoute(LegalPayment()));
            }
          },
          height: 0.06,
          backColor: Colors.black,
        ),
      ),
      appBar: AppBar(
        title: Text('Legal and Registration '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Legal and Registration ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 65),
            Text(
              'We offer comprehensive legal support to gamers, including contract negotiation and review, legal representation, and trademark protection. Our services are designed to handle the legal complexities of the esports industry, allowing you to focus on your game and career growth.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 65),
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildLegalSessionCard(
                      'World Cup 2024 registration',
                      'assets/services/legal/open.png',
                      'Opening Now!',
                      Colors.green,
                      true),
                  buildLegalSessionCard(
                      'Riyadh Season',
                      'assets/services/legal/close.png',
                      'Opening Soon!',
                      Colors.orange,
                      false),
                  buildLegalSessionCard(
                      'Gamers 8',
                      'assets/services/legal/gamers8.png',
                      'Coming Soon!',
                      Colors.red,
                      false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLegalSessionCard(
    String title,
    String image,
    String description,
    Color descriptioncolor,
    bool isOpen,
  ) {
    bool isSelected = selectedLegalSession == title;
    return GestureDetector(
      onTap: () {
        if (isOpen) {
          setState(() {
            selectedLegalSession = title;
            selectedLegalSessionImage = image;
          });
        } else {
          Functions.showSnackBar(context, 'Ohh No!',
              'You can select only open events', Colors.red);
        }
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
                  Text(
                    description,
                    style: TextStyle(color: descriptioncolor),
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
