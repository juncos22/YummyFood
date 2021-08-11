import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/home/components/categories.dart';
import 'package:recipe_app/screens/home/components/recip_bundle_card.dart';
import 'package:recipe_app/services/recipe_service.dart';
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
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
              child: StreamBuilder<List<QueryDocumentSnapshot<Recipe>>>(
                stream: RecipeService().showRecipes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Recipe> recipeList = [];
                    var data = snapshot.data!;
                    data.forEach((element) {
                      var recipe = element.data();
                      recipeList.add(recipe);
                    });
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (SizeConfig.orientation == Orientation.landscape)
                                  ? 2
                                  : 1),
                      itemCount: recipeList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        return RecipeBundleCard(recipe: recipeList[index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
