import 'package:blablacar/theme/theme.dart';
import 'package:flutter/material.dart';

class RidePrefInput extends StatelessWidget {
  const RidePrefInput({
    super.key,
    required this.title,
    required this.iconLeft,
    this.iconRight,
    required this.onPressed,
    this.onPressedRight,
  });
  final String title;
  final IconData iconLeft;
  final VoidCallback onPressed;
  final IconData? iconRight;
  final VoidCallback? onPressedRight;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      leading: Icon(iconLeft, color: BlaColors.iconNormal),
      trailing:
          iconRight != null
              ? IconButton(
                icon: Icon(iconRight, color: BlaColors.iconNormal),
                onPressed: onPressedRight,
              )
              : null,
    );
  }
}
