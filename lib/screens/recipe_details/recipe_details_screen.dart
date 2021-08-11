import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/size_config.dart';

import 'components/recipe_info.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({Key? key, required this.recipeItem})
      : super(key: key);
  final Recipe recipeItem;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: NetworkImage(this.recipeItem.photo!),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: defaultSize * 0.9,
              ),
              RecipeInfo(recipeItem: this.recipeItem,)
            ],
          ),
        ),
      ),
    );
  }
}


