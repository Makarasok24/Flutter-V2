import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/screens/ride_pref/widgets/ride_pref_location_tile.dart';
import 'package:blablacar/service/locations_service.dart';
import 'package:blablacar/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key, this.initLocation});
  final Location? initLocation;
  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> searchFilterLocation = [];

  // handle pop back to first screen
  void onBackPressed() {
    Navigator.of(context).pop();
  }

  // handle change search text
  void onChangeSearch(String newInput) {
    List<Location> newLocation = [];

    if (newInput.length > 1) {
      newLocation =
          LocationsService.availableLocations
              .where(
                (location) => location.name.toLowerCase().contains(
                  newInput.toLowerCase(),
                ),
              )
              .toList();
    }
    setState(() {
      searchFilterLocation = newLocation;
    });
  }

  void onSelectedLocation(Location selectLocation) {
    Navigator.of(context).pop(selectLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlaSearchBar(
            onBackPressed: onBackPressed,
            onChangeSearch: onChangeSearch,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchFilterLocation.length,
              itemBuilder:
                  (context, index) => RidePrefLocationTile(
                    location: searchFilterLocation[index],
                    onSelected: () => onSelectedLocation(searchFilterLocation[index]),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlaSearchBar extends StatefulWidget {
  const BlaSearchBar({
    super.key,
    required this.onBackPressed,
    required this.onChangeSearch,
  });
  final VoidCallback onBackPressed;
  final Function(String inputText) onChangeSearch;
  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController inputSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputSearchController.addListener(() {
      widget.onChangeSearch(inputSearchController.text);
    });
  }

  @override
  void dispose() {
    inputSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: BlaSpacings.s,
        left: BlaSpacings.m,
        right: BlaSpacings.m,
      ),
      padding: const EdgeInsets.only(left: BlaSpacings.s, right: BlaSpacings.s),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
        color: BlaColors.backgroundAccent,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBackPressed,
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Search"),
              controller: inputSearchController,
              onChanged: (value) {
                widget.onChangeSearch(value);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              inputSearchController.clear();
              widget.onChangeSearch("");
            },
            icon: Icon(Icons.close_outlined),
          ),
        ],
      ),
    );
  }
}
