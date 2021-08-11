import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem(
      {Key? key, required this.recipeAvatar, required this.recipeName})
      : super(key: key);
  final String recipeAvatar;
  final String recipeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(recipeAvatar, fit: BoxFit.cover,),
      ),
      title: Text(recipeName),
    );
  }
}
