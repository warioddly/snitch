import 'package:flutter/cupertino.dart';

class BottomNavigationItem {

  const BottomNavigationItem({
    required this.label,
    required this.view,
    required this.icon,
  });

  final String label;
  final Widget view;
  final IconData icon;

}