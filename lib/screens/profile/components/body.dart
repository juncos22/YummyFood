import 'package:flutter/material.dart';
import 'package:recipe_app/screens/profile/components/info.dart';
import 'package:recipe_app/size_config.dart';

import 'profile_menu_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Info(
            image: 'assets/images/perfil.jpg',
            name: 'John Doe',
            email: 'johndoe@gmail.com',
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 2,
          ),
          ProfileMenuItem(
            iconSrc: 'assets/icons/bookmark_fill.svg',
            title: 'Saved Recipes',
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: 'assets/icons/chef.svg',
            title: 'Super Plan',
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: 'assets/icons/language.svg',
            title: 'Change Language',
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: 'assets/icons/help.svg',
            title: 'Help',
            press: () {},
          ),
        ],
      ),
    );
  }
}
