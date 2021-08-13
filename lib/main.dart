import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'package:recipe_app/services/recipe_service.dart';

import 'providers/nav_items.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavItems>(create: (_) => NavItems()),
        ChangeNotifierProvider<RecipeProvider>(
            create: (_) => RecipeProvider(RecipeService())),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'YummyFood',
            debugShowCheckedModeBanner: false,
            theme: provider.themeData,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
