import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/screens/new_recipe/components/recipe_form.dart';

class NewRecipeScreen extends StatelessWidget {
  const NewRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Recipe'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).isDark
            ? kPrimaryColor
            : Colors.white,
      ),
      body: RecipeForm(),
    );
  }
}
