import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolve/screens/hackathons_screen.dart';
import 'package:resolve/screens/submit_problem_screen.dart';
import 'package:resolve/widgets/bottom_navigation_bar.dart' as custom;
import 'package:resolve/widgets/community_engagement_carousel.dart';
import 'package:resolve/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).userName;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person),
                  color: Colors.black,
                ),
                Center(
                  child: Text(
                    'Welcome, $userName!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.notifications_none),
                  color: Colors.black,
                  onPressed: () {
                    // Navigate to notifications
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Community Engagement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CommunityEngagementCarousel(),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildMenuCard(context, 'About Us', Icons.info, () {
                  // navigateTo(context, AboutUsScreen());
                }),
                _buildMenuCard(context, 'Submit a Problem', Icons.add_box, () {
                  navigateTo(context, SubmitProblemScreen());
                }),
                _buildMenuCard(context, 'Hackathons', Icons.event, () {
                  navigateTo(context, HackathonsScreen());
                }),
                _buildMenuCard(context, 'Community Feedback', Icons.feedback,
                    () {
                  // navigateTo(context, CommunityFeedbackScreen());
                }),
                _buildMenuCard(context, 'News & Updates', Icons.newspaper, () {
                  // navigateTo(context, NewsAndUpdatesScreen());
                }),
                _buildMenuCard(context, 'Get Involved', Icons.group, () {
                  // navigateTo(context, GetInvolvedScreen());
                }),
                _buildMenuCard(context, 'More', Icons.more_horiz, () {
                  // navigateTo(context, MoreScreen());
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: custom.NavigationBar(),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.blue),
              SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
