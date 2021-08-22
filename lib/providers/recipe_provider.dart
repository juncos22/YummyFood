import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_service.dart';

enum RecipeState { INITIAL_STATE, LOADING_STATE, SUCCESS_STATE, FAILURE_STATE }

class RecipeProvider extends ChangeNotifier {
  final RecipeService _recipeService;
  List<Recipe> recipeList = [];
  List<Recipe> favoriteList = [];
  final List<String> categoryList = ["All"];
  String _categorySearch = "";
  int categoryIndex = 0;

  RecipeState recipeState = RecipeState.INITIAL_STATE;

  RecipeProvider(this._recipeService);

  // String? get categorySearch => this._categorySearch;

  void setCategoryIndex(int categoryIndex) {
    this.categoryIndex = categoryIndex;
    notifyListeners();
  }

  void setCategorySearch(String categorySearch) {
    this._categorySearch = categorySearch;
    notifyListeners();
  }

  // TODO: Eliminar las categorias que no aplican a ninguna receta actualmente
  void setCategoryList() {
    // this.categoryList.removeRange(1, this.categoryList.length);
    this.recipeList.forEach((recipe) {
      if (!this.categoryList.contains(recipe.category)) {
        this.categoryList.add(recipe.category!);
      }
    });
    notifyListeners();
  }

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
    } on Exception catch (e) {
      print(e.toString());
      this.recipeState = RecipeState.FAILURE_STATE;
      notifyListeners();
    }

    Future.delayed(Duration(milliseconds: 1500), () {
      this.recipeState = RecipeState.INITIAL_STATE;
      notifyListeners();
    });
  }

  Future<List<Recipe>> showRecipes() async {
    try {
      var snapshots =
          this._categorySearch.isNotEmpty && this._categorySearch != "All"
              ? await this._recipeService.filterRecipes(this._categorySearch)
              : await this._recipeService.showRecipes();

      List<Recipe> tempList = [];
      snapshots.docs.forEach((document) {
        var recipe = document.data();
        tempList.add(recipe);
      });
      this.recipeList = tempList;
      notifyListeners();

      this.setCategoryList();
    } on Exception catch (e) {
      print(e.toString());
    }
    return this.recipeList;
  }

  Future<void> setFavorite(Recipe recipe) async {
    try {
      await this._recipeService.setFav(recipe);

      this.recipeState = RecipeState.SUCCESS_STATE;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      this.recipeState = RecipeState.FAILURE_STATE;
      notifyListeners();
    }
    Future.delayed(Duration(milliseconds: 1500), () {
      this.recipeState = RecipeState.INITIAL_STATE;
      notifyListeners();
    });
  }

  Future<List<Recipe>> getFavorites() async {
    try {
      var recipeSnapshots = await this._recipeService.filterFavs();

      List<Recipe> tempList = [];
      recipeSnapshots.docs.forEach((element) {
        var recipe = element.data();
        tempList.add(recipe);
      });

      this.favoriteList = tempList;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());

      this.recipeState = RecipeState.FAILURE_STATE;
      notifyListeners();
    }
    return this.favoriteList;
  }
}
