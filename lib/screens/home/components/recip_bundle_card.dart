import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipe_details/recipe_details_screen.dart';
import 'package:recipe_app/size_config.dart';

class RecipeBundleCard extends StatelessWidget {
  const RecipeBundleCard({Key? key, required this.recipe, this.press})
      : super(key: key);
  final Recipe recipe;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Card(
        color: kPrimaryColor,
        clipBehavior: Clip.antiAlias,
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: GestureDetector(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(recipeItem: recipe),
                ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: NetworkImage(recipe.photo!),
                fit: BoxFit.cover,
                height: defaultSize * 20,
              ),
              ListTile(
                title: Text(recipe.name!),
                subtitle: Text(recipe.category!),
              )
            ],
          ),
        ));
  }

  Row buildInfoRow(double defaultSize, {String? iconSrc, text}) {
    return Row(
      children: [
        SvgPicture.asset(
          iconSrc!,
          width: defaultSize * 2.5,
          color: Colors.white,
        ),
        SizedBox(
          width: defaultSize,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
