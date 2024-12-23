import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolve/widgets/bottom_navigation_bar.dart' as custom;
import 'package:resolve/widgets/community_engagement_carousel.dart';
import 'package:resolve/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).userName;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'), // Replace with dynamic user profile URL
          ),
        ),
        title: Center(
          child: Text(
            'Welcome, $userName!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              // Navigate to notifications
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Here’s what’s happening today!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildMenuCard(context, 'About Us', Icons.info, () {}),
                _buildMenuCard(context, 'Submit a Problem', Icons.add_box, () {
                  // Navigate to Submit a Problem
                }),
                _buildMenuCard(context, 'Hackathons', Icons.event, () {}),
                _buildMenuCard(
                    context, 'Community Feedback', Icons.feedback, () {}),
                _buildMenuCard(
                    context, 'News & Updates', Icons.newspaper, () {}),
                _buildMenuCard(context, 'Get Involved', Icons.group, () {}),
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
        ],
      ),
      bottomNavigationBar: custom.NavigationBar(),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
