import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/new_recipe/components/recipe_form.dart';

class NewRecipeScreen extends StatelessWidget {
  const NewRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Recipe'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: RecipeForm(),
    );
  }
}
