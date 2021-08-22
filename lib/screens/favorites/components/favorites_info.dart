import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/screens/recipe_details/recipe_details_screen.dart';

class FavoritesInfo extends StatelessWidget {
  const FavoritesInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: Provider.of<RecipeProvider>(context).getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var favorites = snapshot.data;
          if (favorites != null && favorites.length > 0) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              shrinkWrap: true,
              itemCount:
                  Provider.of<RecipeProvider>(context).favoriteList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 2.0,
                  color: Provider.of<ThemeProvider>(context).isDark
                      ? kPrimaryColor
                      : kAccentColor,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: Provider.of<ThemeProvider>(context).isDark
                              ? [
                                  kPrimaryColor,
                                  kPrimaryColor.withOpacity(0.3),
                                ]
                              : [
                                  kAccentColor,
                                  kAccentColor.withOpacity(0.3),
                                ])),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailsScreen(recipeItem: favorites[index]),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(favorites[index].photo!),
                    ),
                    horizontalTitleGap: 30.0,
                    title: Text(
                      favorites[index].name!,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Provider.of<ThemeProvider>(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        favorites[index].isFavorite =
                            !favorites[index].isFavorite;
                        Provider.of<RecipeProvider>(context, listen: false)
                            .setFavorite(favorites[index]);
                      },
                      icon: SvgPicture.asset(favorites[index].isFavorite
                          ? 'assets/icons/heart_active.svg'
                          : 'assets/icons/heart_disabled.svg'),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Here will appear your favorite recipes..',
                style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDark
                        ? kPrimaryColor
                        : kTextColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            snapshot.error.toString(),
            style: TextStyle(
              color: kErrorColor,
              fontSize: 18.0,
            ),
          ));
        }
        return Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      },
    );
  }
}
