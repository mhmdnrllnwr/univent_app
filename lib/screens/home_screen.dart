import 'package:flutter/material.dart';
import 'package:univent_app/screens/create_ev.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'home_page.dart';
import 'favourite_page.dart';
import 'search_page.dart';
import 'profile_page.dart';
import 'create_ev.dart';
import 'qr_page_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavouritePage(),
    //SearchPage(),
    GenerateQRCode(),
    ProfilePage(),
    CreateEvent(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('My App'),
        backgroundColor: Colors.blue,
      ),
      */
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
