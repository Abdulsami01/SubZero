import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subzero/screens/user/legal/legal_payment.dart';
import '../../../provider/sponsorship_provider.dart';
import '../../../utils/constants/button_constant.dart';
import '../../../utils/functions/functions.dart';
import '../user_homeScreen/user_homeScreen.dart';

class SponsorshipServices extends StatefulWidget {
  @override
  _CoachingServices createState() => _CoachingServices();
}

class _CoachingServices extends State<SponsorshipServices> {
  String? selectedSponsorText;
  String? selectedSponsorImage;

  @override
  Widget build(BuildContext context) {
    void _confirmationDialouge() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Thank You',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Your request has been received. We will contact you shortly.',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                CustomActionButton(
                    backColor: Colors.white,
                    textStyle: TextStyle(fontSize: 18, color: Colors.black),
                    text: 'Done',
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => UserHomeScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    height: 0.06),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 10, left: 10),
        child: CustomActionButton(
          textStyle: TextStyle(color: Colors.white),
          text: 'Request Quotation',
          onPressed: () {
            if (selectedSponsorText == null) {
              Functions.showSnackBar(
                  context, 'Ohh No!', 'Please select any session', Colors.red);
            } else {
              Provider.of<SponsorshipState>(context, listen: false)
                  .selectSponsorship(
                      selectedSponsorText!, selectedSponsorImage!);
              _confirmationDialouge();
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
              ' Sponsorship Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Enhance your visibility and marketability with our comprehensive sponsorship services. We offer a range of services designed to build a strong personal brand, create high-quality content, manage media relations, and secure valuable sponsorship deals.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildSponsorshipCard(
                    'Sponsorship Acquisition',
                    'assets/services/sponsorship/sponsor1.png',
                  ),
                  buildSponsorshipCard(
                    'Social Media Management',
                    'assets/services/sponsorship/social.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSponsorshipCard(
    String title,
    String image,
  ) {
    bool isSelected = selectedSponsorText == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSponsorText = title;
          selectedSponsorImage = image;
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
