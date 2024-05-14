import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../utils/customColors.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: CustomColors.bodyBackgroundColor,
      color: CustomColors.appBarColor,
      animationDuration: const Duration(milliseconds: 300),
      index: widget.currentIndex,
      onTap: widget.onTap,
      items: const [
        Icon(
          Icons.group_add,
          size: 30,
          color: CustomColors.bodyBackgroundColor,
        ),
        Icon(
          Icons.qr_code_scanner,
          size: 30,
          color: CustomColors.bodyBackgroundColor,
        ),
        Icon(
          Icons.file_download,
          size: 30,
          color: CustomColors.bodyBackgroundColor,
        ),
      ],
    );
  }
}
