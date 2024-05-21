import 'package:flutter/material.dart';

typedef BottomNavigationItem = (String, Widget, IconData);

class BottomNavigation extends StatelessWidget {

  const BottomNavigation({super.key, this.items, this.onTap, this.index = 0});

  final int index;
  final List<BottomNavigationItem>? items;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {

    if (items == null) {
      return const SizedBox();
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: onTap,
        items: _generateItems(items!),
      ),
    );
  }

  List<BottomNavigationBarItem> _generateItems(List<BottomNavigationItem> items) {
    return items.map((item) => BottomNavigationBarItem(
        icon: Icon(item.$3),
        label: ""
    )).toList();
  }
}