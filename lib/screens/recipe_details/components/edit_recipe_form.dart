import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_service.dart';

class EditRecipeForm extends StatefulWidget {
  final Recipe recipe;

  EditRecipeForm({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipeFormState createState() => _EditRecipeFormState();
}

class _EditRecipeFormState extends State<EditRecipeForm> {
  final TextEditingController nameInput = new TextEditingController();
  final TextEditingController categoryInput = new TextEditingController();
  final TextEditingController ingredientsInput = new TextEditingController();
  XFile? photoFile;

  @override
  void initState() {
    super.initState();
    this.nameInput.text = this.widget.recipe.name!;
    this.categoryInput.text = this.widget.recipe.category!;
    this.ingredientsInput.text = this.widget.recipe.ingredients!;
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
              child: Image(
                image: (this.photoFile != null)
                    ? Image.file(File(photoFile!.path)).image
                    : NetworkImage(this.widget.recipe.photo!),
                fit: BoxFit.cover,
                width: 30.0,
                height: 30.0,
              ),
            ),
            TextField(
              controller: this.nameInput,
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: this.categoryInput,
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: this.ingredientsInput,
              keyboardType: TextInputType.name,
              maxLines: 5,
            ),
            Container(
              padding: EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: _onSaveRecipe, child: Text('Save Recipe')),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                ],
              ),
            )
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
    this.widget.recipe.name = this.nameInput.text.toString();
    this.widget.recipe.category = this.categoryInput.text.toString();
    this.widget.recipe.ingredients = this.ingredientsInput.text.toString();
    this.widget.recipe.photo =
    await RecipeService().saveRecipePhoto(this.photoFile!);

    await RecipeService().saveRecipe(this.widget.recipe).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: kPrimaryLightColor,
            ),
            title: Text('Recipe updated successfully'),
          )));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: kErrorColor,
            ),
            title: Text(error.toString()),
          )));
    });
    Navigator.pop(context);
  }
}