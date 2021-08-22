import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/screens/recipe_details/recipe_details_screen.dart';
import 'package:recipe_app/size_config.dart';

class RecipeBundleCard extends StatelessWidget {
  const RecipeBundleCard({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: kAccentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
            height: defaultSize * 20,
            alignment: Alignment.topCenter,
            child: Image.network(
              recipe.photo!,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetailsScreen(recipeItem: recipe),
                  ));
            },
            title: Text(
              recipe.name!,
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              recipe.category!,
              style: TextStyle(
                color: kTextSecondaryColor,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                recipe.isFavorite = !recipe.isFavorite;
                Provider.of<RecipeProvider>(context, listen: false)
                    .setFavorite(recipe);
              },
              icon: SvgPicture.asset(recipe.isFavorite
                  ? 'assets/icons/heart_active.svg'
                  : 'assets/icons/heart_disabled.svg'),
            ),
          )
        ],
      ),
    );
  }
}
