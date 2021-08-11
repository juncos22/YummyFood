import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipe_list/components/recipe_item.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? _searchText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<List<QueryDocumentSnapshot<Recipe>>>(
        stream: RecipeService().filterRecipes('category'),
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
                return RecipeItem(
                    recipeAvatar: recipeList[index].photo!,
                    recipeName: recipeList[index].name!);
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
    );
  }
}
