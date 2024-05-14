import 'package:carbon_foodprint_pro/adminPage.dart';
import 'package:carbon_foodprint_pro/carbonFoodPrint.dart';
import 'package:carbon_foodprint_pro/patients.dart';
import 'package:carbon_foodprint_pro/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const AdminPage();
      case 1:
        return const CarbonFoodPrint();
      case 2:
        return const Patients();
      default:
        return const AdminPage();
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
