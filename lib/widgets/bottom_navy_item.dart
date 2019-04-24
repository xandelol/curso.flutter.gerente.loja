library bottom_navy_bar;

import 'package:flutter/material.dart';

class BottomNavyBar extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color backgroundColor;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;

  BottomNavyBar(
      {Key key,
        this.currentIndex = 0,
        this.iconSize = 30,
        this.backgroundColor,
        @required this.items,
        @required this.onItemSelected}) {
    assert(items != null);
    assert(items.length >= 2 || items.length >= 5);
    assert(onItemSelected != null);
  }

  @override
  _BottomNavyBarState createState() {
    return _BottomNavyBarState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }
}

class _BottomNavyBarState extends State<BottomNavyBar> {
  final int currentIndex;
  final double iconSize;
  Color backgroundColor;
  List<BottomNavyBarItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _BottomNavyBarState(
      {@required this.items,
        this.currentIndex,
        this.backgroundColor,
        this.iconSize,
        @required this.onItemSelected});

  Widget _buildItem(BottomNavyBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: 90,
      height: double.maxFinite,
      duration: Duration(milliseconds: 270),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
            topRight: Radius.circular(15), bottomLeft: Radius.circular(-15),
            bottomRight: Radius.circular(-15)
        ),
      ),
      child: ListView(
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 90,
            height: double.maxFinite,
            child: Center(
              child: IconTheme(
                data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor.withOpacity(1)
                        : Colors.white
                ),
                child: item.icon,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _selectedIndex = currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: 46,
          decoration: BoxDecoration(
              color: backgroundColor
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 56,
          padding: EdgeInsets.only(left: 8, right: 8),
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(15),
                topLeft: Radius.circular(15)),
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () {
                  onItemSelected(index);

                  setState(() {
                    _selectedIndex = index;
                    backgroundColor = item.activeColor;
                  });
                },
                child: _buildItem(item, _selectedIndex == index),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class BottomNavyBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;

  BottomNavyBarItem(
      {@required this.icon,
        @required this.title,
        this.activeColor = Colors.blue,
        this.inactiveColor}) {
    assert(icon != null);
    assert(title != null);
  }
}
