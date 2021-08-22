import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/screens/home/components/body.dart';
import 'package:recipe_app/screens/new_recipe/new_recipe_screen.dart';
import 'package:recipe_app/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
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
        backgroundColor: kPrimaryLightColor,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Provider.of<ThemeProvider>(context).isDark
          ? kPrimaryColor
          : Colors.white,
      elevation: 0,
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
