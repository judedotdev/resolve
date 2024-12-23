import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CommunityEngagementCarousel extends StatelessWidget {
  const CommunityEngagementCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/photo-1506748686214-e9df14d4d9d0.jpg',
      'assets/images/photo-1518600506278-4e8ef466b810.jpg',
      'assets/images/photo-1497493292307-31c376b6e479.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: images.map((imagePath) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}
