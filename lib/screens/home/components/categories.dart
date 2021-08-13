import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
      child: SizedBox(
        height: SizeConfig.defaultSize * 3.5,
        child: Consumer<RecipeProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  buildCategoryItem(context, index),
            );
          },
        ),
      ),
    );
  }

  Widget buildCategoryItem(BuildContext context, int index) {
    RecipeProvider provider = Provider.of<RecipeProvider>(context);
    return GestureDetector(
      onTap: () {
        provider.setCategoryIndex(index);
        provider.setCategorySearch(provider.categoryList[index]);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: SizeConfig.defaultSize * 2,
        ),
        decoration: BoxDecoration(
            color: provider.categoryIndex == index
                ? Color(0xFFEFF3EE)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultSize * 2,
            vertical: SizeConfig.defaultSize * 0.5,
          ),
          child: Text(
            provider.categoryList[index],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: provider.categoryIndex == index
                  ? kPrimaryColor
                  : Color(0xFFC2C2B5),
            ),
          ),
        ),
      ),
    );
  }
}
