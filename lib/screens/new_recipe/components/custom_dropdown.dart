import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/providers/theme_provider.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {Key? key,
      required this.items,
      this.selectedItem,
      this.onChanged,
      required this.hintText})
      : super(key: key);

  final List<String> items;
  final String? selectedItem;
  final void Function(String?)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      icon: Icon(
        Icons.arrow_drop_down,
        size: 24.0,
        color: Provider.of<ThemeProvider>(context).isDark
            ? kPrimaryColor
            : kTextColor,
      ),
      value: this.selectedItem,
      elevation: 16,
      underline: Container(
        height: 2.0,
      ),
      hint: Text(
        this.hintText,
        style: TextStyle(fontSize: 18.0),
      ),
      onChanged: this.onChanged,
      items: this.items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          child: Text(
            value,
            style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDark
                    ? kPrimaryColor
                    : kTextColor),
          ),
          value: value,
        );
      }).toList(),
    );
  }
}
