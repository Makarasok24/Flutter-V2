import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/theme/theme.dart';
import 'package:flutter/material.dart';

class RidePrefLocationTile extends StatelessWidget {
  const RidePrefLocationTile({
    super.key,
    required this.location,
    required this.onSelected,
  });
  final Location location;
  final Function() onSelected;

  String get locationName => location.name;
  String get locationCountry => location.country.name;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(locationName, style: TextStyle(color: BlaColors.iconNormal)),
      subtitle: Text(
        locationCountry,
        style: TextStyle(color: BlaColors.greyLight),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: onSelected,
    );
  }
}
