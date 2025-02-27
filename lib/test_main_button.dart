import 'package:blablacar/theme/theme.dart';
import 'package:blablacar/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: AvailableRideScreen()),
    );
  }
}

class AvailableRideScreen extends StatelessWidget {
  const AvailableRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Rides Today',
          style: TextStyle(color: BlaColors.white),
        ),
        backgroundColor: BlaColors.primary,
      ),
      backgroundColor: BlaColors.greyLight,
      body: Column(
        children: [
          SizedBox(height: BlaSpacings.m),
          BlaButton(label: "Book", onPressed: () {}),
          SizedBox(height: BlaSpacings.m),
          BlaButton(label: "Book", onPressed: () {}, isPrimary: false),
          SizedBox(height: BlaSpacings.m),
          BlaButton(label: "Book", onPressed: () {}, isDisabled: true),
          SizedBox(height: BlaSpacings.m),
          BlaButton(
            label: "Contact Valodia",
            onPressed: () {},
            icon: Icons.date_range_outlined,
          ),
          SizedBox(height: BlaSpacings.m),
          BlaButton(
            label: "Request to book",
            onPressed: () {},
            isPrimary: false,
            icon: Icons.date_range_outlined,
          ),
        ],
      ),
    );
  }
}
