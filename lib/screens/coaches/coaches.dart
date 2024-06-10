import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CoachingProfilesScreen extends StatelessWidget {
  final List<Map<String, String>> coaches = [
    {
      'name': 'Ahmed',
      'location': 'Riyadh, Saudi Arabia',
      'hours': '1.2K',
      'players': '120',
      'rating': '4.9',
      'bio':
          '🎮 Coach AhmedX 🎮 🌟 Strategic Mindset | 🏆 E sports Veteran 🕹 Specializing in MOBA 🏆 Coach to Champions | 📈 Data-Driven Tactics 👥 Mentor | 💬 Contact me for Coaching Sessions 🔥 "Winning isn’t everything, but wanting to win is."',
      'image': 'assets/services/coaching/coaches/ahmed.png'
    },
    {
      'name': 'AI Coach',
      'location': 'Virtual',
      'hours': '3.5K',
      'players': '300',
      'rating': '5.0',
      'bio':
          '🤖 AI Coach 🤖 🌟 Advanced Strategies | 🏆 E sports Guru 🕹 Specializing in All Games 🏆 Coach to All Levels | 📈 Data-Driven Tactics 👥 Mentor | 💬 Contact me for Coaching Sessions 🔥 "Adapt, Overcome, Succeed."',
      'image': 'assets/services/coaching/coaches/aicoach.png'
    },
    {
      'name': 'Wejdan',
      'location': 'Dubai, UAE',
      'hours': '900',
      'players': '80',
      'rating': '4.7',
      'bio':
          '🎮 Coach Wejdan 🎮 🌟 Creative Strategies | 🏆 E sports Enthusiast 🕹 Specializing in FPS 🏆 Coach to Winners | 📈 Data-Driven Tactics 👥 Mentor | 💬 Contact me for Coaching Sessions 🔥 "Precision, Patience, and Practice."',
      'image': 'assets/services/coaching/coaches/wejdan.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coaching Profiles'),
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: coaches.length,
            itemBuilder: (context, index, realIndex) {
              final coach = coaches[index];
              return buildCoachProfile(coach);
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.8,
              enlargeCenterPage: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCoachProfile(Map<String, String> coach) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/services/coaching/coaches/coach_banner.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              Positioned(
                bottom: -50,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(coach['image']!),
                ),
              ),
            ],
          ),
          SizedBox(
              height:
                  60), // Adjust this to create the necessary space for the avatar
          Text(
            coach['name']!,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text(
                coach['location']!,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    coach['hours']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Coaching Hours'),
                ],
              ),
              Column(
                children: [
                  Text(
                    coach['players']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Trained Players'),
                ],
              ),
              Column(
                children: [
                  Text(
                    coach['rating']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Rating'),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              coach['bio']!,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
