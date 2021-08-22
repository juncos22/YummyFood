import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/providers/theme_provider.dart';

import 'components/favorites_info.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).isDark
            ? kPrimaryColor
            : Colors.white,
        title: Text('Favorite Recipes'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FavoritesInfo(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
