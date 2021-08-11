import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_service.dart';

enum RecipeState { INITIAL_STATE, LOADING_STATE, SUCCESS_STATE, FAILURE_STATE }

class RecipeProvider extends ChangeNotifier {
  final RecipeService _recipeService;
  final List<Recipe> recipeList = [];
  RecipeState recipeState = RecipeState.INITIAL_STATE;

  RecipeProvider(this._recipeService);

  Future<String> saveRecipePhoto(XFile recipeFile) async {
    return await this._recipeService.saveRecipePhoto(recipeFile);
  }

  Future<void> saveRecipe(Recipe recipe) async {
    try {
      this.recipeState = RecipeState.LOADING_STATE;
      notifyListeners();
      await this._recipeService.saveRecipe(recipe);
      this.recipeState = RecipeState.SUCCESS_STATE;
      notifyListeners();
      Future.delayed(Duration(milliseconds: 1500), () {
        this.recipeState = RecipeState.INITIAL_STATE;
        notifyListeners();
      });
    } on Exception catch(e) {
      print(e.toString());
      this.recipeState = RecipeState.FAILURE_STATE;
      notifyListeners();
      Future.delayed(Duration(milliseconds: 1500), () {
        this.recipeState = RecipeState.INITIAL_STATE;
        notifyListeners();
      });
    }
  }
}