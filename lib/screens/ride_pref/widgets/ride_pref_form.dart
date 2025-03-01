import 'package:blablacar/screens/ride_pref/widgets/ride_pref_input.dart';
import 'package:blablacar/theme/theme.dart';
import 'package:blablacar/utils/date_time_util.dart';
import 'package:blablacar/widgets/actions/bla_button.dart';
import 'package:blablacar/widgets/display/bla_divider.dart';
import 'package:blablacar/widgets/inputs/bla_location_picker.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void departurePressed() async {
    Location? selectedDeparture = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (ctx) => BlaLocationPicker(initLocation: departure),
      ),
    );

    if (selectedDeparture != null) {
      setState(() {
        departure = selectedDeparture;
      });
    }
  }

  void arrivalPressed() async {
    Location? selectedArrival = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (ctx) => BlaLocationPicker(initLocation: arrival),
      ),
    );

    if (selectedArrival != null) {
      setState(() {
        arrival = selectedArrival;
      });
    }
  }

  void swapLocationPressed() {
    setState(() {
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel =>
      departure != null ? departure!.name : "Leave from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get seateLabel => requestedSeats.toString();

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.s),
          child: Column(
            children: [
              // 1 - Departure location
              // TODO
              RidePrefInput(
                title: departureLabel,
                iconLeft: Icons.radio_button_off,
                iconRight: Icons.swap_vert,
                onPressed: departurePressed,
                onPressedRight: swapLocationPressed,
              ),
              const BlaDivider(),
              // 2 - Arrival location
              // TODO
              RidePrefInput(
                title: arrivalLabel,
                iconLeft: Icons.radio_button_off,
                onPressed: arrivalPressed,
              ),
              const BlaDivider(),
              // 3 - Departure date
              // TODO
              RidePrefInput(
                title: dateLabel,
                iconLeft: Icons.calendar_month_outlined,
                onPressed: () {},
              ),
              const BlaDivider(),
              // 4 - Number of seats
              // TODO
              RidePrefInput(
                title: seateLabel,
                iconLeft: Icons.person_outline_outlined,
                iconRight: null,
                onPressed: () {},
              ),
              const BlaDivider(),
              // 5 - Submit button
              // TODO
              const SizedBox(height: BlaSpacings.m),
              BlaButton(label: "Search", onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
