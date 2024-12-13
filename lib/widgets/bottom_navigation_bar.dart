import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home, size: 30),
          title: const Text("Home", style: TextStyle(fontSize: 16)),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.favorite, size: 30),
          title: const Text("Favourite", style: TextStyle(fontSize: 16)),
          selectedColor: Colors.red,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.search, size: 30),
          title: const Text("Search", style: TextStyle(fontSize: 16)),
          selectedColor: Colors.green,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.person, size: 30),
          title: const Text("Profile", style: TextStyle(fontSize: 16)),
          selectedColor: Colors.purple,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.key, size: 30),
          title: const Text("Sign In", style: TextStyle(fontSize: 16)),
          selectedColor: const Color.fromARGB(255, 14, 109, 187),
        ),
      ],
    );
  }
}
