import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/screens/recipe_list/components/recipe_item.dart';
import 'package:recipe_app/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<RecipeProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.recipeList.length,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return RecipeItem(
                recipeAvatar: provider.recipeList[index].photo!,
                recipeName: provider.recipeList[index].name!);
          },
        );
      },
    );
  }
}
