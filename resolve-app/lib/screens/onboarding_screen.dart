import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage =
                        (index == 2); // Adjust based on the number of pages
                  });
                },
                children: [
                  buildPage(
                    image: 'assets/images/identify_problems.jpeg',
                    title: 'Identify Problems',
                    description:
                        'Spot issues in your community that need solutions.',
                  ),
                  buildPage(
                    image: 'assets/images/collaborate.jpeg',
                    title: 'Collaborate',
                    description:
                        'Work together with like-minded individuals to create impactful tech solutions.',
                  ),
                  buildPage(
                    image: 'assets/images/earn_rewards.jpeg',
                    title: 'Earn Rewards',
                    description:
                        'Get rewarded for your innovative insights and solutions.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SmoothPageIndicator(
              controller: _controller,
              count: 3, // Adjust based on the number of pages
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 16,
                activeDotColor: Colors.blue,
                dotColor: Colors.grey.shade400,
              ),
              onDotClicked: (index) {
                // Navigate to the clicked page
                _controller.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(isLastPage ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(
      {required String image,
      required String title,
      required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 200,
          height: 200,
        ), // Placeholder for assets
        const SizedBox(height: 32),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
