import 'package:blablacar/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
    this.isPrimary = true,
    this.icon,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool isPrimary;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isPrimary
            ? BlaColors.primary
            : isDisabled
            ? BlaColors.greyLight
            : BlaColors.white;
    final Color borderSide =
        isPrimary && !isDisabled
            ? BlaColors.primary
            : isDisabled
            ? BlaColors.disabled
            : BlaColors.neutralLighter;

    return ElevatedButton(
      onPressed: !isDisabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: BlaSpacings.l,
          vertical: BlaSpacings.m,
        ),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderSide),
          borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, color: isPrimary ? BlaColors.white : BlaColors.primary),
          if (icon != null) SizedBox(width: BlaSpacings.s),
          Text(
            label,
            style: BlaTextStyles.button.copyWith(
              color: isPrimary ? Colors.white : BlaColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
