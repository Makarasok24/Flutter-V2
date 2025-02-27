import 'package:blablacar/model/ride/ride.dart';
import 'package:blablacar/service/rides_service.dart';
import 'package:blablacar/theme/theme.dart';
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
    final today = DateTime.now();
    final availableRidesToday =
        RidesService.availableRides
            .where(
              (ride) =>
                  ride.departureDate.day == today.day &&
                  ride.departureDate.month == today.month &&
                  ride.departureDate.year == today.year,
            )
            .toList();
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
          availableRidesToday.isEmpty
              ? Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'No rides available today',
                  style: BlaTextStyles.body.copyWith(
                    color: BlaColors.textNormal,
                  ),
                ),
              )
              : Expanded(
                child: ListView.builder(
                  itemCount: availableRidesToday.length,
                  itemBuilder: (context, index) {
                    final ride = availableRidesToday[index];
                    return RideTile(
                      ride: ride,
                      onPressed: () {
                        // 1 - Navigate to the rides screen (with a buttom to top animation)
                      },
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}

class RideTile extends StatelessWidget {
  final Ride ride;
  final VoidCallback? onPressed;

  const RideTile({super.key, required this.ride, this.onPressed});

  String get title =>
      "${ride.departureLocation.name} → ${ride.arrivalLocation.name}";

  String get subTitle =>
      "${ride.departureDate},  ${ride.availableSeats} passenger${ride.availableSeats > 1 ? "s" : ""}";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      subtitle: Text(
        subTitle,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),
    );
  }
}
