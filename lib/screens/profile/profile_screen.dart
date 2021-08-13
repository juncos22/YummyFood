import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/providers/theme_provider.dart';
import 'package:recipe_app/screens/profile/components/body.dart';
import 'package:recipe_app/size_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: MyBottomNavBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: SizedBox(),
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Text('Profile'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize * 1.6,
            ),
          ),
        ),
        Row(
          children: [
            Text('Switch theme'),
            Consumer<ThemeProvider>(
              builder: (context, provider, child) {
                return Switch(
                  value: provider.isDark,
                  onChanged: (value) {
                    provider.changeTheme();
                  },
                );
              },
            )
          ],
        )
      ],
    );
  }
}
