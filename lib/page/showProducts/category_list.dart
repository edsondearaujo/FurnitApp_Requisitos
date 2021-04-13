


import 'package:flutter/material.dart';
import 'package:furnitapp/constants.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key key,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;
  List categories = ['Todos', 'Sofa', 'Mesas', 'Cadeiras', 'Camas'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: kDefaultPadding),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
                color: index == selectedIndex
                    ? Colors.white.withOpacity(0.4)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
