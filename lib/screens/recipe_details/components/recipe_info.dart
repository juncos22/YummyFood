
import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/size_config.dart';

import 'edit_recipe_form.dart';

class RecipeInfo extends StatelessWidget {
  final Recipe recipeItem;

  const RecipeInfo({Key? key, required this.recipeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      recipeItem.name!,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: defaultSize * 0.9,
                    ),
                    Text(
                      recipeItem.category!,
                      style: TextStyle(
                        color: kTextSecondaryColor,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async =>
                      await onEditRecipe(context, this.recipeItem),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: kAccentColor,
                    ),
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.all(5.0),
          ),
          SizedBox(
            height: defaultSize * 2,
          ),
          Text(
            'Ingredients',
            style: TextStyle(fontSize: 18.0, color: kTextColor),
          ),
          SizedBox(
            height: defaultSize * 3,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text(
                  recipeItem.ingredients!,
                  style: TextStyle(color: kTextColor, fontSize: 16.0),
                )
              ],
            ),
          )
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


