import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/screens/home/components/categories.dart';
import 'package:recipe_app/screens/home/components/recip_bundle_card.dart';
import 'package:recipe_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Categories(),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
                future: Provider.of<RecipeProvider>(context).showRecipes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (SizeConfig.orientation == Orientation.landscape)
                                  ? 2
                                  : 1,
                        ),
                        itemCount: Provider.of<RecipeProvider>(context)
                            .recipeList
                            .length,
                        itemBuilder: (context, index) {
                          return RecipeBundleCard(
                              recipe: Provider.of<RecipeProvider>(context)
                                  .recipeList[index]);
                        });
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(color: kErrorColor),
                      ),
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
