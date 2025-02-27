import 'package:flutter/material.dart';
import 'package:resolve_app/screens/hackathons_screen.dart';
import 'package:resolve_app/screens/home_screen.dart';
import 'package:resolve_app/screens/profile_screen.dart';
import 'package:resolve_app/screens/submit_problem_screen.dart';
import 'package:resolve_app/widgets/side_navigation.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Submit',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.code),
          label: 'Hackathons',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle navigation
        switch (index) {
          case 0:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
            break;
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SideNavigation()));
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => SubmitProblemScreen()));
            break;
          case 3:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HackathonsScreen()));
            break;
          case 4:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            break;
        }
      },
    );
  }
}
