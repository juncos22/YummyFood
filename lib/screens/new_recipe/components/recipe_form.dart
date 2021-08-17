import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/screens/new_recipe/components/custom_dropdown.dart';
import 'package:recipe_app/screens/new_recipe/components/custom_textfield.dart';
import 'package:recipe_app/size_config.dart';

class RecipeForm extends StatefulWidget {
  RecipeForm({
    Key? key,
  }) : super(key: key);

  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _preparationController = TextEditingController();

  String selectedType = "Desayuno";
  String selectedCategory = "Aperitivo";
  XFile? _recipePhoto;
  late bool isNameValid;
  late bool isIngredientsValid;
  late bool isPreparationValid;
  String? nameErrorText;
  String? ingredientsErrorText;
  String? preparationErrorText;

  @override
  void initState() {
    super.initState();
    this.isNameValid = false;
    this.isIngredientsValid = false;
    this.isPreparationValid = false;
  }

  void _selectOption() async {
    await showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select option'),
          actions: [
            IconButton(
              onPressed: () {
                this._selectImage();
                Navigator.pop(context);
              },
              icon: Icon(Icons.image_rounded),
            ),
            IconButton(
              onPressed: () {
                this._takePhoto();
                Navigator.pop(context);
              },
              icon: Icon(Icons.camera_alt_rounded),
            ),
          ],
        );
      },
    );
  }

  void _selectImage() async {
    this._recipePhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _takePhoto() async {
    this._recipePhoto =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            Container(
              width: size.width - 5,
              height: size.height / 5,
              margin: EdgeInsets.only(bottom: 2.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (this._recipePhoto != null)
                      ? Image.file(
                          File(this._recipePhoto!.path),
                        ).image
                      : AssetImage('assets/images/placeholder.jpg'),
                ),
              ),
            ),
            TextButton(
              onPressed: this._selectOption,
              child: Text(
                'Select Recipe Photo',
                style: TextStyle(
                  color: !Provider.of<ThemeProvider>(context).isDark
                      ? kTextColor
                      : kPrimaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomTextField(
              controller: this._nameController,
              errorText: this.nameErrorText,
              inputType: TextInputType.name,
              isMultiline: false,
              labelText: "Recipe Name",
              validatorFunction: this._validateNameField,
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomDropdown(
              items: [
                "Desayuno",
                "Almuerzo",
                "Merienda",
                "Cena",
                "Bebida",
                "Snack",
                "Vegana"
              ],
              hintText: "Recipe Type",
              selectedItem: this.selectedType,
              onChanged: (value) {
                setState(() {
                  this.selectedType = value!;
                });
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomDropdown(
              items: [
                "Aperitivo",
                "Entrada",
                "Plato Principal",
                "Postre",
              ],
              hintText: "Recipe Category",
              selectedItem: this.selectedCategory,
              onChanged: (value) {
                setState(() {
                  this.selectedCategory = value!;
                });
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomTextField(
              controller: this._ingredientsController,
              errorText: this.ingredientsErrorText,
              inputType: TextInputType.multiline,
              isMultiline: true,
              labelText: "Recipe Ingredients",
              validatorFunction: this._validateIngredientsField,
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomTextField(
              controller: this._preparationController,
              errorText: this.preparationErrorText,
              inputType: TextInputType.multiline,
              isMultiline: true,
              labelText: "Recipe Preparation",
              validatorFunction: this._validatePreparationField,
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
                onPressed: (this.isNameValid &&
                        this.isIngredientsValid &&
                        this.isPreparationValid &&
                        this._recipePhoto != null)
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

  void _validateNameField(String value) {
    setState(() {
      this.isNameValid = value.isNotEmpty;
    });
    if (!this.isNameValid) {
      this.nameErrorText = 'The recipe name is needed';
    } else {
      this.nameErrorText = null;
    }
  }

  void _validatePreparationField(String value) {
    setState(() {
      this.isPreparationValid = value.isNotEmpty;
    });
    if (!this.isPreparationValid) {
      this.preparationErrorText = 'The preparation is nedded';
    } else {
      this.preparationErrorText = null;
    }
  }

  void _validateIngredientsField(String value) {
    setState(() {
      this.isIngredientsValid = value.isNotEmpty;
    });
    if (!this.isIngredientsValid) {
      this.ingredientsErrorText = 'The ingredients are needed';
    } else {
      this.ingredientsErrorText = null;
    }
  }

  void _saveRecipe() async {
    var recipe = Recipe();
    recipe.name = this._nameController.text;
    recipe.type = this.selectedType;
    recipe.category = this.selectedCategory;
    recipe.ingredients = this._ingredientsController.text;
    recipe.preparation = this._preparationController.text;
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
