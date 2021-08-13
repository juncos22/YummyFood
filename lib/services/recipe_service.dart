import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> saveRecipePhoto(XFile recipeFile) async {
    var uploadTask = await _storage
        .ref('uploads/${recipeFile.name}')
        .putFile(File(recipeFile.path));

    return await uploadTask.storage
        .ref('uploads/${recipeFile.name}')
        .getDownloadURL();
  }

  Future<void> saveRecipe(Recipe recipe) async {
    var recipesRef = _firestore.collection('recipes');
    String recipeId = recipe.id ?? recipesRef.doc().id;

    return await recipesRef.doc(recipeId).set({
      'id': recipeId,
      'name': recipe.name,
      'category': recipe.category,
      'ingredients': recipe.ingredients,
      'photo': recipe.photo
    }, SetOptions(merge: true));
  }

  Future<QuerySnapshot<Recipe>> showRecipes() {
    return _firestore
        .collection('recipes')
        .withConverter<Recipe>(
          fromFirestore: (snapshot, _) => Recipe.fromJson(snapshot.data()!),
          toFirestore: (recipe, _) => recipe.toJson(),
        )
        .get();
  }

  Future<QuerySnapshot<Recipe>> filterRecipes(String category) {
    return _firestore
        .collection('recipes')
        .withConverter<Recipe>(
          fromFirestore: (snapshot, _) => Recipe.fromJson(snapshot.data()!),
          toFirestore: (recipe, _) => recipe.toJson(),
        )
        .where('category', isEqualTo: category)
        .get();
  }
}
