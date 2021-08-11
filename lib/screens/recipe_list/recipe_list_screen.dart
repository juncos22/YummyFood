import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/recipe_list/components/body.dart';
import 'package:recipe_app/size_config.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: searchBar(defaultSize),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  PreferredSizeWidget searchBar(double defaultSize) {
    return AppBar(
      title: Container(
        height: defaultSize * 5,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Recipe Category',
            prefixIcon: Icon(Icons.search_rounded, color: kPrimaryColor,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: kPrimaryColor
              ),
            ),
          ),
        ),
      ),
      leadingWidth: 0,
    );
  }
}
