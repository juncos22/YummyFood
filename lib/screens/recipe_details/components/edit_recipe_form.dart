import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/custom_dropdown.dart';
import 'package:recipe_app/components/custom_textfield.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/utils/recipe_utils.dart';

class EditRecipeForm extends StatefulWidget {
  final Recipe recipe;

  EditRecipeForm({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipeFormState createState() => _EditRecipeFormState();
}

class _EditRecipeFormState extends State<EditRecipeForm> {
  final TextEditingController nameInput = new TextEditingController();
  final TextEditingController ingredientsInput = new TextEditingController();
  final TextEditingController preparationInput = new TextEditingController();
  String? selectedCategory = recipeCategories[0];
  String? selectedType = recipeTypes[0];

  XFile? photoFile;

  late bool isNameValid;
  String? nameErrorText;

  late bool isPreparationValid;
  String? preparationErrorText;

  late bool isIngredientsValid;
  String? ingredientsErrorText;

  @override
  void initState() {
    super.initState();
    this.nameInput.text = this.widget.recipe.name!;
    this.ingredientsInput.text = this.widget.recipe.ingredients!;
    this.preparationInput.text = this.widget.recipe.preparation!;

    this.isNameValid = false;
    this.isIngredientsValid = false;
    this.isPreparationValid = false;
  }

  void _validateNameField(String value) {
    setState(() {
      this.isNameValid = value.isNotEmpty;
    });
    if (!this.isNameValid) {
      this.nameErrorText = 'Recipe name is needed';
    } else {
      this.nameErrorText = null;
    }
  }

  void _validatePreparationField(String value) {
    setState(() {
      this.isPreparationValid = value.isNotEmpty;
    });
    if (!this.isPreparationValid) {
      this.preparationErrorText = 'Preparation is nedded';
    } else {
      this.preparationErrorText = null;
    }
  }

  void _validateIngredientsField(String value) {
    setState(() {
      this.isIngredientsValid = value.isNotEmpty;
    });
    if (!this.isIngredientsValid) {
      this.ingredientsErrorText = 'Ingredients are needed';
    } else {
      this.ingredientsErrorText = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _onSelectImage,
              child: CircleAvatar(
                backgroundImage: (this.photoFile != null)
                    ? Image.file(
                        File(photoFile!.path),
                        width: 80,
                      ).image
                    : NetworkImage(this.widget.recipe.photo!),
              ),
            ),
            CustomTextField(
              controller: this.nameInput,
              errorText: this.nameErrorText,
              inputType: TextInputType.name,
              isMultiline: false,
              labelText: 'New recipe Name',
              validatorFunction: this._validateNameField,
            ),
            CustomDropdown(
              items: recipeTypes,
              hintText: "Recipe Types",
              selectedItem: this.selectedType,
              onChanged: (type) {
                setState(() {
                  this.selectedType = type;
                });
              },
            ),
            CustomDropdown(
              items: recipeCategories,
              hintText: "Recipe Categories",
              selectedItem: this.selectedCategory,
              onChanged: (category) {
                setState(() {
                  this.selectedCategory = category;
                });
              },
            ),
            CustomTextField(
              controller: this.ingredientsInput,
              errorText: this.ingredientsErrorText,
              inputType: TextInputType.multiline,
              isMultiline: true,
              labelText: 'New ingredients',
              validatorFunction: this._validateIngredientsField,
            ),
            CustomTextField(
              controller: this.preparationInput,
              errorText: this.preparationErrorText,
              inputType: TextInputType.multiline,
              isMultiline: true,
              labelText: 'New preparation',
              validatorFunction: this._validatePreparationField,
            ),
            Container(
              padding: EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: (this.isNameValid &&
                              this.isIngredientsValid &&
                              this.isPreparationValid &&
                              this.photoFile != null)
                          ? _onSaveRecipe
                          : null,
                      child: Text('Save Recipe')),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSelectImage() async {
    this.photoFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> _onSaveRecipe() async {
    this.widget.recipe.name = this.nameInput.text;
    this.widget.recipe.type = this.selectedType;
    this.widget.recipe.category = this.selectedCategory;
    this.widget.recipe.ingredients = this.ingredientsInput.text;
    this.widget.recipe.preparation = this.preparationInput.text;
    this.widget.recipe.photo =
        await RecipeService().saveRecipePhoto(this.photoFile!);

    await Provider.of<RecipeProvider>(context, listen: false)
        .saveRecipe(this.widget.recipe);

    Navigator.pop(context);
  }
}
