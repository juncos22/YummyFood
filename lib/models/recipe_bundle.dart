import 'package:flutter/material.dart';

class RecipeBundle {
  final int id, chefs, recipes;
  final String title, description, imageSrc;
  final Color color;

  RecipeBundle(
      {required this.id,
      required this.chefs,
      required this.recipes,
      required this.title,
      required this.description,
      required this.imageSrc,
      required this.color});

  static List<RecipeBundle> recipeBundles = [
    RecipeBundle(
        id: 1,
        chefs: 15,
        recipes: 95,
        title: "Cook something new everyday",
        description: "New and tasty recipes every day",
        imageSrc: "assets/images/cook_new.png",
        color: Color(0xFFDB2D40)),
    RecipeBundle(
        id: 2,
        chefs: 15,
        recipes: 95,
        title: "Cook something new everyday",
        description: "New and tasty recipes every day",
        imageSrc: "assets/images/cook_new.png",
        color: Color(0xFF47DB2D)),
    RecipeBundle(
        id: 3,
        chefs: 15,
        recipes: 95,
        title: "Cook something new everyday",
        description: "New and tasty recipes every day",
        imageSrc: "assets/images/cook_new.png",
        color: Color(0xFF655C5D)),
    RecipeBundle(
        id: 4,
        chefs: 15,
        recipes: 95,
        title: "Cook something new everyday",
        description: "New and tasty recipes every day",
        imageSrc: "assets/images/cook_new.png",
        color: Color(0xFF2D53DB)),
    RecipeBundle(
        id: 5,
        chefs: 15,
        recipes: 95,
        title: "Cook something new everyday",
        description: "New and tasty recipes every day",
        imageSrc: "assets/images/cook_new.png",
        color: Color(0xFF842DDB)),
    RecipeBundle(
        id: 6,
        chefs: 15,
        recipes: 95,
        title: "Cook something new everyday",
        description: "New and tasty recipes every day",
        imageSrc: "assets/images/cook_new.png",
        color: Color(0xFFCE0A0A)),
    RecipeBundle(
        id: 7,
        chefs: 15,
        recipes: 95,
        title: "Cook something new everyday",
        description: "New and tasty recipes every day",
        imageSrc: "assets/images/cook_new.png",
        color: Color(0xFFDBAA2D)),
  ];
}
