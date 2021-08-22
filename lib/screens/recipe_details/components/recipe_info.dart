import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/size_config.dart';

import 'edit_recipe_form.dart';

class RecipeInfo extends StatelessWidget {
  final Recipe recipeItem;

  const RecipeInfo({Key? key, required this.recipeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeItem.name!,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDark
                            ? kPrimaryColor
                            : kTextColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: defaultSize * 0.9,
                    ),
                    Text(
                      recipeItem.category!,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDark
                            ? kPrimaryLightColor
                            : kTextSecondaryColor,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async =>
                      await onEditRecipe(context, this.recipeItem),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isDark
                          ? kAccentColor
                          : kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Provider.of<ThemeProvider>(context).isDark
                  ? kPrimaryColor
                  : kTextColor,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            recipeItem.ingredients!,
            style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDark
                    ? kPrimaryColor
                    : kTextColor,
                fontSize: 16.0),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Preparation',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Provider.of<ThemeProvider>(context).isDark
                  ? kPrimaryColor
                  : kTextColor,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            recipeItem.preparation!,
            style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDark
                    ? kPrimaryColor
                    : kTextColor,
                fontSize: 16.0),
          ),
          Consumer<RecipeProvider>(
            builder: (context, provider, child) {
              switch (provider.recipeState) {
                case RecipeState.LOADING_STATE:
                  return ListTile(
                    leading: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      'Updating the recipe...',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  );
                case RecipeState.SUCCESS_STATE:
                  return ListTile(
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      'Update successfully!',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  );
                case RecipeState.INITIAL_STATE:
                  return Container();
                case RecipeState.FAILURE_STATE:
                  return ListTile(
                    leading: Icon(
                      Icons.error_outline_rounded,
                      color: kErrorColor,
                    ),
                    title: Text(
                      'Error while updating the recipe',
                      style: TextStyle(color: kErrorColor),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> onEditRecipe(BuildContext context, Recipe recipeItem) async {
    await showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Recipe'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          content: EditRecipeForm(
            recipe: recipeItem,
          ),
        );
      },
    );
  }
}
