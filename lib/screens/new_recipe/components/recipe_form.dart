import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/size_config.dart';

class RecipeForm extends StatefulWidget {
  RecipeForm({
    Key? key,
  }) : super(key: key);

  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  TextEditingController _recipeNameController = TextEditingController();
  TextEditingController _recipeCategoryController = TextEditingController();
  TextEditingController _recipeIngredientsController = TextEditingController();
  XFile? _recipePhoto;
  late bool isRecipeNameValid;
  late bool isRecipeCategoryValid;
  late bool isRecipeIngredientsValid;
  String? recipeNameErrorText;
  String? recipeCategoryErrorText;
  String? recipeIngredientsErrorText;

  @override
  void initState() {
    super.initState();
    this.isRecipeNameValid = false;
    this.isRecipeCategoryValid = false;
    this.isRecipeIngredientsValid = false;
  }

  void _selectImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((file) {
      _recipePhoto = file;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            Container(
              width: SizeConfig.defaultSize * 10,
              height: SizeConfig.defaultSize * 10,
              margin: EdgeInsets.only(bottom: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: kPrimaryColor,
                  width: 1.5,
                ),
                image: DecorationImage(
                  image: (this._recipePhoto != null)
                      ? Image.file(File(this._recipePhoto!.path)).image
                      : AssetImage('assets/images/app_icon.png'),
                ),
              ),
            ),
            TextButton(
              onPressed: _selectImage,
              child: Text(
                'Select Recipe Photo',
                style: TextStyle(
                  color: !Provider.of<ThemeProvider>(context).isDark
                      ? kTextColor
                      : kPrimaryColor,
                ),
              ),
            ),
            TextField(
              controller: this._recipeNameController,
              onChanged: _validateRecipeNameField,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                labelText: 'Recipe Name',
                labelStyle: TextStyle(color: kPrimaryColor),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kErrorColor, width: 2.0),
                ),
                errorStyle: TextStyle(color: kErrorColor),
                errorText: this.recipeNameErrorText,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kErrorColor, width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: this._recipeCategoryController,
              onChanged: _validateRecipeCategoryField,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                labelText: 'Recipe Category',
                labelStyle: TextStyle(color: kPrimaryColor),
                errorText: this.recipeCategoryErrorText,
                errorStyle: TextStyle(color: kErrorColor),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kErrorColor, width: 2.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kErrorColor, width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: this._recipeIngredientsController,
              onChanged: _validateRecipeIngredientsField,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                labelText: 'Recipe Ingredients',
                labelStyle: TextStyle(color: kPrimaryColor),
                errorText: this.recipeIngredientsErrorText,
                errorStyle: TextStyle(color: kErrorColor),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kErrorColor, width: 2.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: kErrorColor, width: 2.0),
                ),
              ),
              maxLines: 5,
            ),
            SizedBox(
              height: 15.0,
            ),
            Consumer<RecipeProvider>(builder: (context, recipeProvider, child) {
              switch (recipeProvider.recipeState) {
                case RecipeState.INITIAL_STATE:
                  return Container();
                case RecipeState.LOADING_STATE:
                  return showMessageBar(
                      context, "Saving recipe...", null, null);
                case RecipeState.SUCCESS_STATE:
                  return showMessageBar(context, "Recipe successfully saved",
                      Icons.info_outline_rounded, kPrimaryColor);
                case RecipeState.FAILURE_STATE:
                  return showMessageBar(context, "Error saving the recipe",
                      Icons.error_outline_outlined, kErrorColor);
              }
            }),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: SizeConfig.defaultSize * 40,
              height: SizeConfig.defaultSize * 6,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
                color: kPrimaryColor,
              ),
              child: TextButton(
                onPressed: (this.isRecipeNameValid &&
                        this.isRecipeCategoryValid &&
                        this.isRecipeIngredientsValid)
                    ? _saveRecipe
                    : null,
                child: Text(
                  'Save Recipe',
                  style: TextStyle(color: kTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateRecipeNameField(String value) {
    setState(() {
      this.isRecipeNameValid = value.isNotEmpty;
    });
    if (!this.isRecipeNameValid) {
      this.recipeNameErrorText = 'Complete the recipe name';
    } else {
      this.recipeNameErrorText = null;
    }
  }

  void _validateRecipeCategoryField(String value) {
    setState(() {
      this.isRecipeCategoryValid = value.isNotEmpty;
    });
    if (!this.isRecipeCategoryValid) {
      this.recipeCategoryErrorText = 'Complete the recipe category';
    } else {
      this.recipeCategoryErrorText = null;
    }
  }

  void _validateRecipeIngredientsField(String value) {
    setState(() {
      this.isRecipeIngredientsValid = value.isNotEmpty;
    });
    if (!this.isRecipeIngredientsValid) {
      this.recipeIngredientsErrorText = 'Complete the recipe ingredients';
    } else {
      this.recipeIngredientsErrorText = null;
    }
  }

  void _saveRecipe() async {
    if (this._recipePhoto == null) {
      this._recipePhoto = new XFile('assets/images/app_icon.png');
    }

    var recipe = Recipe();
    recipe.name = this._recipeNameController.value.text;
    recipe.category = this._recipeCategoryController.value.text;
    recipe.ingredients = this._recipeIngredientsController.value.text;
    recipe.photo = await Provider.of<RecipeProvider>(context, listen: false)
        .saveRecipePhoto(this._recipePhoto!);

    await Provider.of<RecipeProvider>(context, listen: false)
        .saveRecipe(recipe);
  }

  Widget showMessageBar(
      BuildContext context, String message, IconData? icon, Color? color) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: color,
            )
          : CircularProgressIndicator(),
      title: Text(
        message,
        style: TextStyle(color: color),
      ),
    );
  }
}
