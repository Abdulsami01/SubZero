import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:subzero/screens/user/user_homeScreen/user_homeScreen.dart';
import 'package:subzero/utils/constants/button_constant.dart';
import 'package:subzero/utils/functions/functions.dart';
import '../../../provider/coaching_provider.dart';
import '../../../provider/package_provider.dart';

class CoachingCheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coachingState = Provider.of<CoachingState>(context);
    final packageState = Provider.of<PackageState>(context);
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
                  'Thank You!',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'You have successfully registered. We will contact you shortly.',
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
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: CustomActionButton(
          textStyle: TextStyle(color: Colors.white),
          text: 'Confirm & Pay',
          onPressed: () {
            _confirmationDialouge();
          },
          height: 0.06,
          backColor: Colors.black,
        ),
      ),
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Coaching Session',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (coachingState.selectedCoachingSession != null)
              buildSelectedItem(
                context,
                coachingState.selectedCoachingSession!,
                coachingState.selectedCoachingSessionImage!,
              ),
            SizedBox(height: 16),
            Text(
              'Selected Game',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (coachingState.selectedGame != null)
              buildSelectedItem(
                context,
                coachingState.selectedGame!,
                coachingState.selectedGameImage!,
              ),
            SizedBox(height: 16),
            Text(
              'Selected Coach',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (coachingState.selectedCoach != null)
              ListTile(
                title: Text(coachingState.selectedCoach!),
                leading: Image.asset(
                    'assets/services/coaching/coaches/${coachingState.selectedCoach!.toLowerCase().replaceAll(' ', '')}.png'),
              ),
            SizedBox(height: 16),
            Text(
              'Selected Package',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (packageState.selectedPackage != null)
              ListTile(
                title: Text(
                  packageState.selectedPackage!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      packageState.selectedPackagePrice!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedItem(
      BuildContext context, String title, String imagePath) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
