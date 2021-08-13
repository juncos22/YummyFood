import 'package:flutter/material.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/home/components/body.dart';
import 'package:recipe_app/screens/new_recipe/new_recipe_screen.dart';
import 'package:recipe_app/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewRecipeScreen(),
            ),
          );
        },
        elevation: 2.0,
        backgroundColor: kAccentColor,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Yummy Food',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kAccentColor,
        ),
      ),
    );
  }
}
